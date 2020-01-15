module Yugo
  module Ruby
    class BinaryOperation < Syntax

      Contract Operator, Syntax, Syntax => C::Any
      def initialize(op, left, right)
        @op = op
        @left = left
        @right = right
      end

      def to_sexp
        s(:send, @left.to_sexp, @op.to_sexp, @right.to_sexp)
      end
    end
  end
end
