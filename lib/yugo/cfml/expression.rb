module Yugo
  module CFML
    class Expression < Node
      def ruby_ast
        Yugo::CFML.ruby_ast(elements[1])
      end
    end
  end
end