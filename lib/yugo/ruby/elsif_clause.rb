module Yugo
  module Ruby
    class ElsifClause < Syntax
      def initialize(predicate)
        @predicate = predicate
      end

      def compile
        "elsif #{@predicate.compile}"
      end

      def to_sexp
        [:elsif, @predicate.to_sexp]
      end
    end
  end
end
