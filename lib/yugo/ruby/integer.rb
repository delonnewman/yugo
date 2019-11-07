module Yugo
  module Ruby
    class Integer < SelfEvaluating
      def to_sexp
        @value.to_i
      end
    end
  end
end