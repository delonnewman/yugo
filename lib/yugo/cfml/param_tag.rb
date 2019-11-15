module Yugo
  module CFML
    class ParamTag < Node
      # TODO: add support for scoped variables, and other tag attributes
      def ruby_ast(scope)
        attrs   = Yugo::CFML.parse_attribute_list(attribute_list, scope)
        name    = attrs.fetch(:name)
        ident   = name.as_identifier
        default = attrs[:default]
        
        if default.nil? && !scope.variable_exists?(ident.symbol)
          raise "The required parameter #{name.value.upcase} was not provided."
        else
          Yugo::Ruby::Assignment.new(
            Yugo::Ruby::InstanceVariable.new(ident), default, :'||=')
        end
      end
    end
  end
end
