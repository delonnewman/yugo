module Yugo
  module Ruby
    class Program < Syntax
      # TODO: add indentation level?
      def initialize(expressions)
        @expressions = expressions
      end

      def compile
        @expressions.map(&:compile).join("\n")
      end

      def to_sexp
        @expressions.map(&:to_sexp)
      end
    end
  end
end
