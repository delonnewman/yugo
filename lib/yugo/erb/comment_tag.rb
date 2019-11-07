module Yugo
  module ERB
    class CommentTag < Syntax
      def initialize(code)
        @code = code
      end

      def compile
        "<%# #{code.compile} %>"
      end
    end
  end
end
