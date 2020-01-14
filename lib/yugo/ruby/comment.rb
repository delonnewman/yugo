module Yugo
  module Ruby
    class Comment < Syntax
      def initialize(text)
        @text = text
      end

      def compile
        "# #{@text}"
      end

      def to_sexp
        [:comment, @text]
      end
    end
  end
end
