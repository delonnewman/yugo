module Yugo
  module Ruby
    class Program < Syntax
      include Enumerable

      # TODO: add indentation level?

      Contract C::Maybe[C::ArrayOf[Syntax]] => C::Any
      def initialize(expressions = nil)
        @expressions = expressions || []
      end

      def each
        if block_given?
          @expressions.each(&Proc.new)
        else
          @expressions.each
        end
      end

      def empty?
        @expressions.empty?
      end

      def compile
        "\n" + @expressions.map(&:compile).join("\n") + "\n"
      end

      def to_sexp
        [:program] + @expressions.map(&:to_sexp)
      end
    end
  end
end
