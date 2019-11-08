module Yugo
  module CFML
    class OpenTag < Node
      def content

      end

      def ruby_ast
        name = identifier.text_value.downcase
        class_name = name.capitalize
        if !name.start_with?('cf')
          Yugo::ERB::Text.new(text_value)
        elsif Yugo::Tags.const_exists?(class_name)
          klass = Yugo::Tags.const_get(class_name)
        else
          raise Yugo::TypeError, "#{identifier.text_value.inspect} is not a valid tag"
        end
      end
    end
  end
end