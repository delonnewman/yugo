module Yugo
  module Ruby
    class BlockVariable < Syntax
      attr_reader :name

      Contract Identifier => C::Any
      def initialize(name)
        @name = name
      end

      def to_sexp
        s(:lvar, @name.symbol)
      end
    end
  end
end
