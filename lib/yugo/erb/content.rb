module Yugo
  module ERB
    class Content < Syntax
      def initialize(elements)
        @elements = elements
      end

      def compile
        @elements.map(&:compile).join('')
      end
    end
  end
end