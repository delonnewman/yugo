module Yugo
  module CFML
    class String < Node
      def ruby_ast
        Yugo::Ruby::String.new(text_value)
      end
    end
  end
end