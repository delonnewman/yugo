module Yugo
  module CFML
    class Statement
      def ruby_ast(scope)
        elements.first.ruby_ast(scope)
      end
    end
  end
end
