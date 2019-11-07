module Yugo
  module CFML
    class Quote < Node
      include Syntax

      def ruby_ast
        Yugo::CFML.ruby_ast(expression)
      end
    end
  end
end