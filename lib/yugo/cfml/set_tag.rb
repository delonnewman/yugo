module Yugo
  module CFML
    class SetTag < Node
      def ruby_ast(scope)
        Yugo::ERB::StatementTag.new(statement.ruby_ast(scope))
      end
    end
  end
end
