module Yugo
  module CFML
    class Assignment < Node
      def ruby_ast(scope)
        # TODO: add function scoped variables
        scope_ = function_scoped? ? scope : Yugo::CFML::TOPLEVEL
        if assignee.is_a?(Yugo::CFML::Identifier)
          name = assignee.text_value.downcase.to_sym
          scope_.add_variable(name, true)
          exp = expression.ruby_ast(scope) # expression must be evaluated be for the assignment identifier is added to scope
          scope_.add_variable(name, exp)
          Yugo::Ruby::Assignment.new(assignee.ruby_ast(scope), exp)
        elsif assignee.is_a?(Yugo::CFML::PropertyAccess)
          exp = expression.ruby_ast(scope)
          Yugo::Ruby::Assignment.new(assignee.ruby_ast(scope), exp)
        else
          raise "Don't know how to process this kind of assignment: #{text_value}"
        end
      end

      def function_scoped?
        elements.first.respond_to?(:assignment_scope) && elements.first.assignment_scope.text_value == 'var'
      end
    end
  end
end
