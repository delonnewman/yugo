module Yugo
  module CFML
    class Assignment < Node
      def ruby_ast(scope)
        # TODO: add function scoped variables
        if assignee.is_a?(Yugo::CFML::Identifier)
          name = assignee.text_value.downcase.to_sym
          scope.add_variable(name, true)
          exp = expression.ruby_ast(scope) # expression must be evaluated be for the assignment identifier is added to scope
          scope.add_variable(name, exp)
          Yugo::Ruby::Assignment.new(assignee.ruby_ast(scope), exp)
        elsif assignee.is_a?(Yugo::CFML::PropertyAccess)
          exp = expression.ruby_ast(scope)
          Yugo::Ruby::Assignment.new(assignee.ruby_ast(scope), exp)
        else
          raise "Don't know how to process this kind of assignment: #{text_value}"
        end
      end
    end
  end
end
