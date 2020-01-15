module Yugo
  module Ruby
    class Float < SelfEvaluating
      def to_sexp
        s(:float, compile.to_f)
      end
    end
  end
end
