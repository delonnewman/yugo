module Yugo
  module Ruby
    class Identifier < Syntax
      attr_reader :name

      Contract ::Symbol => C::Any
      def initialize(name)
        @name = name
      end

      def compile
        @name.to_s
      end

      def to_sexp
        @name.to_sym
      end
    end
  end
end
