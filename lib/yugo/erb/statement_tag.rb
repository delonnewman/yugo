module Yugo
  module ERB
    class StatementTag < Syntax
      def initialize(code)
        @code = code
      end

      def compile
        "<% #{@code.compile} %>"
      end

      def to_sexp
        [:erb_statement, @code.to_sexp]
      end
    end
  end
end
