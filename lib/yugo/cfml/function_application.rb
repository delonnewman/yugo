module Yugo
  module CFML
    class FunctionApplication < Node
      MACROS = {
        getbasetemplatepath: -> (node, scope) { Yugo::Ruby::Macro.new(Yugo::Ruby::Identifier.new(:path)) },
        lastlist: -> (node, scope) {
          args = Yugo::CFML.function_arguments(node, scope)
          Yugo::Ruby::MethodResolution.new(
            Yugo::Ruby::MethodResolution.new(
              args[0],
              Yugo::Ruby::MethodCall.new(
                Yugo::Ruby::Identifier.new(:split), [args[1] || Yugo::Ruby::String.new(',')])
            ),
            Yugo::Ruby::Identifier.new(:last)
          )
        }
      }.freeze

      def ruby_ast(scope)
        if (m = MACROS[tag])
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
