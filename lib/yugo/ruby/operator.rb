module Yugo
  module Ruby
    class Operator < Syntax
      Contract ::Symbol => C::Any
      def initialize(op)
        @op = op
      end

      def compile
        @op.to_s
      end

      def to_sexp
        @op
      end
    end
  end
end
