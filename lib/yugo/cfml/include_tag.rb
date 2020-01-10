module Yugo
  module CFML
    class IncludeTag < Node
      def ruby_ast(scope)
        attrs = Yugo::CFML.parse_attribute_list(attribute_list, scope)
        raise 'template is required' unless attrs.key?(:template)
        Yugo::ERB::OutputTag.new(Yugo::Ruby::Macro.new(Yugo::Ruby::Identifier.from(:include), [attrs[:template]]))
      end
    end
  end
end
