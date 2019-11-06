module Yugo
  module Ruby
    class SelfEvaluating < Syntax
      attr_reader :value

      def initialize(value)
        @value = value
      end

      def compile
        @value.to_s
      end
    end
  end
end