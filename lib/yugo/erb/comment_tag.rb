module Yugo
  module ERB
    class CommentTag < Syntax
      def initialize(text)
        @text = text
      end

      def compile
        "<%# #{@text} %>"
      end

      def to_sexp
        [:erb_comment, @text]
      end
    end
  end
end
