module Yugo
  module Ruby
    class Comment < Syntax

      Contract ::String => C::Any
      def initialize(text)
        @text = text
      end

      def compile
        "# #{@text}\n"
      end

      def to_sexp
        [:comment, @text]
      end
    end
  end
end
