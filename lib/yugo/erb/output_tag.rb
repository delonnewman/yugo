module Yugo
  module ERB
    class OutputTag < Syntax
      def initialize(code)
        @code = code
      end

      def compile
        "<%= #{@code.compile} %>"
      end

      def to_sexp
        [:erb_output, @code.to_sexp]
      end
    end
  end
end
