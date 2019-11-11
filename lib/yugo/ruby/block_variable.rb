module Yugo
  module Ruby
    class BlockVariable < Syntax
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def compile
        @name.compile
      end

      def to_sexp
        @name.to_sexp
      end
    end
  end
end
