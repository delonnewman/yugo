module Yugo
  module CFML
    class PrefixOperation < Node
      def ruby_ast(scope)
        Yugo::Ruby::UnaryOperation.new(prefix_unary_op.ruby_ast(scope), prefix_operation.ruby_ast(scope))
      end

      def to_sexp
        [prefix_unary_op.to_sexp, prefix_operation.to_sexp]
      end
    end
  end
end
