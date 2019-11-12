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
    end
  end
end
