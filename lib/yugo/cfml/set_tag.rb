module Yugo
  module CFML
    class SetTag < Node
      def ruby_ast
        Yugo::ERB::StatementTag.new(statement.ruby_ast)
      end
    end
  end
end
