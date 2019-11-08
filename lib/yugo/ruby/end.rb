module Yugo
  module Ruby
    class End < Syntax
      def initialize
      end

      def compile
        'end'
      end

      def to_sexp
        :end
      end
    end
  end
end
