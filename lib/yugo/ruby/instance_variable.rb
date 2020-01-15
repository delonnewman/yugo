module Yugo
  module Ruby
    class InstanceVariable < Syntax
      attr_reader :name

      Contract Identifier => C::Any
      def initialize(name)
        @name = name
      end

      def compile
        "@#{@name.compile}"
      end

      def to_sexp
        s(:ivar, @name.symbol)
      end
    end
  end
end
