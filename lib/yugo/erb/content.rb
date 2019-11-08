module Yugo
  module ERB
    class Content < Syntax
      def initialize(elements)
        @elements = elements
      end

      def compile
        @elements.map(&:compile).join('')
      end

      def to_sexp
        [:erb_content, @elements.map(&:to_sexp)]
      end
    end
  end
end
