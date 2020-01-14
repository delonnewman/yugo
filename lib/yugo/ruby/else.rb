require 'singleton'

module Yugo
  module Ruby
    class Else < Syntax
      include Singleton

      def compile
        'else'
      end

      def to_sexp
        :else
      end
    end
  end
end
