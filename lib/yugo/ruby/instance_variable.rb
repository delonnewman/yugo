module Yugo
  module Ruby
    class InstanceVariable < Syntax
      attr_reader :name

      Contract Identifier => C::Any
      def initialize(name)
        @name = name
      end

      def symbol
        :"@#{@name.symbol}"
      end

      def to_sexp
        s(:ivar, symbol)
      end
    end
  end
end
