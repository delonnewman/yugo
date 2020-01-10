module Yugo
  module Ruby
    class Self < SelfEvaluating
      def initialize
        super('self')
      end

      def to_sexp
        :self
      end
    end
  end
end
