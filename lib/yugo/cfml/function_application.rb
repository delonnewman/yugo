module Yugo
  module CFML
    class FunctionApplication < Node
      def ruby_ast(scope, opts = {})
        if (m = FunctionMacros.macro(tag))
          m.call(self, scope)
        else
          Yugo::Ruby::FunctionApplication.new(
              identifier.ruby_ast(scope, opts),
              Yugo::Utils.function_arguments(self, scope)
          )
        end
      end

      def tag
        @tag ||= identifier.to_sym
      end
    end
  end
end
