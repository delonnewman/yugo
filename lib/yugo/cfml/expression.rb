module Yugo
  module CFML
    class Expression < Node
      def ruby_ast(scope)
        Yugo::CFML.ruby_ast(elements[1], scope)
      end
    end
  end
end
