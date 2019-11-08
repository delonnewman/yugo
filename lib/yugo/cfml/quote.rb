module Yugo
  module CFML
    class Quote < Node
      include Syntax

      def ruby_ast(scope)
        Yugo::CFML.ruby_ast(expression, scope)
      end
    end
  end
end
