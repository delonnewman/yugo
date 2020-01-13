module Yugo
  module CFML
    class CustomTag < Node
      def ruby_ast(scope)
        name = elements.first.text_value.downcase.tr('<cf>', '')
        class_name = name.capitalize
        if Yugo::Tags.const_defined?(class_name)
          klass = Yugo::Tags.const_get(class_name)
          klass.new(Yugo::Utils.attribute_list(elements.first.attribute_list, scope), tag_content.ruby_ast(scope))
        else
          raise "#{elements.first.text_value.tr('<', '')} is not a valid tag"
        end
      end
    end
  end
end
