module Yugo
  module CFML
    class Integer < Node
      def ruby_ast(_scope)
        Yugo::Ruby::Integer.new(text_value)
      end
    end
  end
end
