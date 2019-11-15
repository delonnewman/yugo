require 'singleton'

module Yugo
  module Ruby
    class Boolean < SelfEvaluating; end
    class True < Boolean
      include Singleton

      def initialize
        super('true')
      end

      def to_sexp
        true
      end
    end
    class False < Boolean
      include Singleton

      def initialize
        super('false')
      end

      def to_sexp
        false
      end
    end
  end
end
