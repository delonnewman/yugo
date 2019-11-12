module Yugo
  module CFML
    class ScriptTag < Node
      def ruby_ast(scope)
        Yugo::ERB::StatementTag.new(script_tag_content.ruby_ast(scope))
      end
    end
  end
end
