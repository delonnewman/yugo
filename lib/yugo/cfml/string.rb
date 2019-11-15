module Yugo
  module CFML
    class String < Node
      def ruby_ast(scope)
        Yugo::Ruby::String.new(content)
      end

      def content
        elements.slice(1..elements.length - 2).map(&:text_value).join('')
      end

      def evaluate_elements(elements)
        if elements
          []
        else
          elements.map do |elem|
            p elem
            case elem
            when Yugo::CFML::Quote
              elem.ruby_ast(scope).compile
            else
              evaluate_elements(elem.elements)
            end
          end
        end
      end
    end
  end
end
