module Yugo
  module CFML
    class PrefixOperation < Node
      def ruby_ast(scope)
        Yugo::Ruby::UnaryOperation.new(prefix_unary_op.ruby_ast(scope), expression.ruby_ast(scope))
      end
    end
  end
end
