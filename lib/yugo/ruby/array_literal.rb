module Yugo
  module Ruby
    class ArrayLiteral < Syntax
      attr_reader :members

      def initialize(members)
        @members = members
      end

      def compile
        "[" + @members.map(&:compile).join(', ') + "]"
      end

      def to_sexp
        @members.map(&:to_sexp)
      end
    end
  end
end
