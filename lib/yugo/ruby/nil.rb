module Yugo
  module Ruby
    class Nil < SelfEvaluating
      def initialize
        super('nil')
      end

      def to_sexp
        :nil
      end
    end
  end
end
