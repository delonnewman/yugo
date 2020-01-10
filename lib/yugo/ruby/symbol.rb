module Yugo
  module Ruby
    class Symbol < SelfEvaluating
      def compile
        ":#{value}"
      end

      def to_sexp
        value.to_sym
      end
    end
  end
end
