module Yugo
  module CFML
    class Node < Treetop::Runtime::SyntaxNode
      def to_sexp
        [self.class.to_s.split('::').last.downcase.to_sym, text_value]
      end
    end
  end
end
