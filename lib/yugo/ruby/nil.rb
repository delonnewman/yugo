module Yugo
  module Ruby
    class Nil < SelfEvaluating
      def initialize
        super('nil')
      end
    end
  end
end