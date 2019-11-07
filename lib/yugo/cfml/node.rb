module Yugo
  module CFML
    class Node < Treetop::Runtime::SyntaxNode
      def compile
        text_value
      end
    end
  end
end