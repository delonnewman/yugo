module Yugo
  module Ruby
    class Symbol < SelfEvaluating
      def to_sexp
        s(:sym, value.to_sym)
      end
    end
  end
end
