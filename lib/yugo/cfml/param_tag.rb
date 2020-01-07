module Yugo
  module CFML
    class ParamTag < Node
      # TODO: add support for scoped variables, and other tag attributes
      def ruby_ast(scope)
        attrs    = Yugo::CFML.parse_attribute_list(attribute_list, scope)
        default  = attrs.fetch(:default, Yugo::Ruby::Nil.new)
        name     = attrs.fetch(:name)
        ident    = name.as_identifier
        assignee = if name.method_access?
                     name.as_method_access
                   else
                     name.as_instance_variable
                   end
        
        if default.nil? && !scope.variable_exists?(ident.symbol)
          raise "The required parameter #{name.value.upcase} was not provided."
        else
          scope.add_variable_name(ident.symbol) unless name.method_access?
          Yugo::ERB::StatementTag.new(
            Yugo::Ruby::Assignment.new(assignee, default, :'||='))
        end
      end
    end
  end
end
