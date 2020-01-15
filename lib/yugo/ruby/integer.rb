module Yugo
  module Ruby
    class Integer < SelfEvaluating
      def to_sexp
        s(:int, @value.to_i)
      end
    end
  end
end
