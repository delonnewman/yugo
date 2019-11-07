module Yugo
  module ERB
    class StatementTag < Syntax
      def initialize(code)
        @code = code
      end

      def compile
        "<% #{code.compile} %>"
      end
    end
  end
end