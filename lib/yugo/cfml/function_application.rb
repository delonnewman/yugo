module Yugo
  module CFML
    class FunctionApplication < Node
      def ruby_ast(scope)
        if (m = FunctionMacros.macros[tag])
          m.call(self, scope)
        else
          Yugo::Ruby::MethodCall.new(
              identifier.ruby_ast(scope),
              Yugo::CFML.function_arguments(self, scope)
          )
        end
      end

      def tag
        @tag ||= identifier.to_sym
      end
    end
  end
end
