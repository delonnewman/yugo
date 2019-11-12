module Yugo
  module CFML
    class FunctionApplication < Node
      def ruby_ast(scope)
        Yugo::Ruby::MethodCall.new(
            identifier.ruby_ast(scope),
            Yugo::CFML.function_arguments(self, scope)
        )
      end
    end
  end
end
