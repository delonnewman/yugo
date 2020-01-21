module Yugo
  module ERB
    class Text < Syntax
      attr_reader :text

      def initialize(text)
        @text = text
      end

      def compile
        @text
      end

      def to_sexp
        @text
      end
    end
  end
end
