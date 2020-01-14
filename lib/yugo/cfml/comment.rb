module Yugo
  module CFML
    class Comment < Node
      def ruby_ast(scope)
        if scope.function_scope? or scope.component_scope?
          Yugo::Ruby::Comment.new(text)
        else
          Yugo::ERB::CommentTag.new(text)
        end
      end

      def text
        @text ||= elements[1].text_value
      end
    end
  end
end
