require 'singleton'

module Yugo
  module Ruby
    class End < Syntax
      include Singleton

      def compile
        'end'
      end

      def to_sexp
        :end
      end
    end
  end
end
