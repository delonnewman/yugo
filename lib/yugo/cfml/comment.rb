module Yugo
  module CFML
    class Comment < Node
      def ruby_ast(_scope)
        Yugo::ERB::CommentTag.new(elements[1].text_value)
      end

      def to_sexp
        [:comment, elements[1].text_value]
      end
    end
  end
end
