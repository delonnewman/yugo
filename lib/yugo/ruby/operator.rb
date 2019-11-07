module Yugo
  module Ruby
    class Operator < Syntax
      def initialize(op)
        @op = op
      end

      def compile
        @op.to_s
      end
    end
  end
end