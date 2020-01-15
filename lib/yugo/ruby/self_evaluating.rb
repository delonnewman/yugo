module Yugo
  module Ruby
    class SelfEvaluating < Syntax
      attr_reader :value

      def initialize(value)
        @value = value
      end
    end
  end
end
