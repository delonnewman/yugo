module Yugo
  module CFML
    class Float < Node
      def ruby_ast(_scope)
        Yugo::Ruby::Float.new(text_value)
      end
    end
  end
end
