module Yugo
  module Ruby
    class UnaryOperation < Syntax
      attr_reader :operator, :expression

      def initialize(operator, expression)
        @operator = operator
        @expression = expression
      end

      def compile
        "#{operator.compile}#{expression.compile}"
      end

      def to_sexp
        [operator.to_sexp, expression.to_sexp]
      end
    end
  end
end
