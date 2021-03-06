module Yugo
  module Ruby
    class Identifier < Syntax
      attr_reader :name

      Contract C::RespondTo[:to_sym] => Identifier
      def self.from(name)
        @idents ||= {}
        sym = name.to_sym
        @idents[sym] ||= new(sym)
      end

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

      def to_sym
        @name
      end
      alias symbol to_sym
    end
  end
end
