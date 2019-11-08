module Yugo
  module Ruby
    class BinaryOperation < Syntax
      # TODO: need to work out order of operations for generated code
      def initialize(op, left, right)
        @op = op
        @left = left
        @right = right
      end

      def to_sexp
        [@op.to_sym, @left.to_sexp, @right.to_sexp]
      end

      def compile
        "(#{@left.compile} #{@op.compile} #{@right.compile})"
      end

      def to_sexp
        [@op.to_sexp, @left.to_sexp, @right.to_sexp]
      end
    end
  end
end
