module Yugo
  module Ruby
    class Program < Syntax
      include Enumerable

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

      def one?
        @expressions.count == 1
      end

      def to_sexp
        if empty?
          nil
        elsif one?
          @expressions.first.to_sexp
        else
          s(:begin, *@expressions.map(&:to_sexp))
        end
      end
    end
  end
end
