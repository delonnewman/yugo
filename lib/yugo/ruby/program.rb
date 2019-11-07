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
    end
  end
end