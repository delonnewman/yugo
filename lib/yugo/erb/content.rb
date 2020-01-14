module Yugo
  module ERB
    class Content < Syntax
      include Enumerable

      Contract C::ArrayOf[Syntax] => C::Any
      def initialize(elements)
        @elements = elements
      end

      def each
        if block_given?
          @elements.each(&Proc.new)
        else
          @elements.each
        end
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
