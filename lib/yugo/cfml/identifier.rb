module Yugo
  module CFML
    class Identifier < Node
      def ruby_ast
        Yugo::Ruby::Identifier.new(text_value)
      end
    end
  end
end