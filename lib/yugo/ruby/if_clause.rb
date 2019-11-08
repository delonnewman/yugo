module Yugo
  module Ruby
    class IfClause < Syntax
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
