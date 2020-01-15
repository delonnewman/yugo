module Yugo
  module Ruby
    class BinaryOperation < Syntax
      def initialize(op, left, right)
        @op = op
        @left = left
        @right = right
      end

      def to_sexp
        [@op.to_sym, @left.to_sexp, @right.to_sexp]
      end

      def to_sexp
        s(:send, @left.to_sexp, @op.to_sexp, @right.to_sexp)
      end
    end
  end
end
