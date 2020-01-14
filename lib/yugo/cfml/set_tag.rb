module Yugo
  module CFML
    class SetTag < Node
      def ruby_ast(scope)
        ast = statement.ruby_ast(scope)
        if scope.erb_context?
          Yugo::ERB::StatementTag.new(ast)
        else
          ast
        end
      end
    end
  end
end
