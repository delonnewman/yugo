module Yugo
  module CFML
    class Statement
      def ruby_ast
        elements.first.ruby_ast
      end
    end
  end
end
