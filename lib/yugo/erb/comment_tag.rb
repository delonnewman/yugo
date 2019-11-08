module Yugo
  module ERB
    class CommentTag < Syntax
      def initialize(code)
        @code = code
      end

      def compile
        "<%# #{code.compile} %>"
      end

      def to_sexp
        [:erb_comment, @code.to_sexp]
      end
    end
  end
end
