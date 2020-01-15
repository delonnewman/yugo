module Yugo
  module Ruby
    class ArrayLiteral < Syntax
      attr_reader :members

      Contract C::ArrayOf[Syntax] => C::Any
      def initialize(members)
        @members = members
      end

      def to_sexp
        s(:array, *@members.map(&:to_sexp))
      end
    end
  end
end
