module Yugo
  module Ruby
    class Return < Syntax

      Contract C::Maybe[Syntax] => C::Any
      def initialize(expression)
        @expression = expression
      end

      def to_sexp
        s(:return, @expression&.to_sexp)
      end
    end
  end
end
