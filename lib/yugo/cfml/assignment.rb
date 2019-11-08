module Yugo
  module CFML
    class Assignment < Node
      def ruby_ast(scope)
        exp = expression.ruby_ast(scope) # expression must be evaluated be for the assignment identifier is added to scope
        # TODO: add function scoped variables
        name = identifier.text_value.downcase
        scope.add_variable_name(name)
        Yugo::Ruby::Assignment.new(identifier.ruby_ast(scope), exp)
      end
    end
  end
end
