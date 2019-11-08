module Yugo
  module CFML
    class Assignment < Node
      # TODO: will need to know about contents for function scoped variables
      def ruby_ast
        Yugo::Ruby::Assignment.new(identifier.ruby_ast, expression.ruby_ast)
      end
    end
  end
end
