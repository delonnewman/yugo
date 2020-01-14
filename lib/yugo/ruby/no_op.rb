require 'singleton'

module Yugo
  module Ruby
    class NoOp < SelfEvaluating
      include Singleton

      def initialize
        super('')
      end

      def to_sexp
        :no_op
      end
    end
  end
end
