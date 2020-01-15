require 'singleton'

module Yugo
  module Ruby
    class Nil < SelfEvaluating
      include Singleton

      def initialize
        super('nil')
      end

      def to_sexp
        s(:nil)
      end
    end
  end
end
