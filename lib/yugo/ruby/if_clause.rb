module Yugo
  module Ruby
    class IfClause < Syntax
      attr_reader :predicate

      Contract Syntax => C::Any
      def initialize(predicate)
        @predicate = predicate
      end

      def compile
        "if #{@predicate.compile}"
      end

      def to_sexp
        [:if, @predicate.to_sexp]
      end
    end
  end
end
