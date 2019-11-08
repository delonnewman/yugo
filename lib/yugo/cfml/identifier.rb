module Yugo
  module CFML
    class Identifier < Node
      def ruby_ast
        # TODO: we'll need variable context for this eventually
        Yugo::Ruby::InstanceVariable.new(Yugo::Ruby::Identifier.new(text_value))
      end
    end
  end
end
