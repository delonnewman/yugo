module Yugo
  module Ruby
    class Else < Syntax
      def initialize
      end

      def compile
        'else'
      end

      def to_sexp
        :else
      end
    end
  end
end
