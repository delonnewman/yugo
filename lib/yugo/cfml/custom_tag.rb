module Yugo
  module CFML
    class CustomTag < Node
      def ruby_ast(scope)
        name = elements.first.text_value.downcase.tr('<cf>', '')
        class_name = name.capitalize
        if Yugo::Tags.const_defined?(class_name)
          klass = Yugo::Tags.const_get(class_name)
          klass.new(_parse_attribute_list(elements.first.attribute_list), tag_content.ruby_ast(scope))
        else
          raise "#{elements.first.text_value.tr('<', '')} is not a valid tag"
        end
      end

      def _parse_attribute_list(list, scope)
        init = {}
        unless list.nil? or list.empty?
          list.elements[0].elements.reject { |elem| elem.text_value =~ /\A\s+\z/ }.reduce(init) do |h, attr|
            h.merge!(attr.identifier.text_value.downcase.to_sym => attr.expression.ruby_ast(scope))
          end
        end
        init
      end
    end
  end
end
