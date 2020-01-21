module Yugo
  module CFML
    class String < Node
      def ruby_ast(scope)
        if no_interpolation?
          Yugo::Ruby::String.new(content.first.text_value)
        else
          elems = evaluate_elements(content, scope)
          if elems.length == 1
            elems.first
          else
            Yugo::Ruby::InterpolatedString.new(elems)
          end
        end
      end

      def content
        @content ||= elements.slice(1..elements.length - 2)
      end

      def no_interpolation?
        @no_interpolation ||= content.first.elements.all?(&Yugo::Utils.method(:plain_node?))
      end

      def evaluate_elements(elements, scope)
        if elements.nil? or elements.empty?
          []
        else
          elems = []
          str = []
          for elem in elements
            if elem.is_a?(Yugo::CFML::Quote)
              str = reset_str!(str, elems)
              elems << Yugo::Ruby::Program.new([elem.ruby_ast(scope)])
            elsif elem.terminal?
              str << elem.text_value
            else
              str = reset_str!(str, elems)
              evaluate_elements(elem.elements, scope).each do |e|
                elems << e
              end
            end
          end
          str = reset_str!(str, elems)
          elems
        end
      end

      def reset_str!(str, elems)
        str_ = str.join('')
        elems << Yugo::Ruby::String.new(str_) unless str_.empty?
        []
      end
    end
  end
end
