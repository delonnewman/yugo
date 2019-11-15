module Yugo
  module CFML
    class FunctionApplication < Node
      MACROS = {
        getbasetemplatepath: -> (node, scope) { Yugo::Ruby::Macro.new(Yugo::Ruby::Identifier.new(:template_path)) },
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
        },
        structnew: -> (node, scope) {
          args = Yugo::CFML.function_arguments(node, scope)
          Yugo::Ruby::MethodResolution.new(
            Yugo::Ruby::Identifier.new(:'Yugo::Struct'),
            Yugo::Ruby::MethodCall.new(Yugo::Ruby::Identifier.new(:new))
          )
        },
        structappend: -> (node, scope) {
          args      = Yugo::CFML.function_arguments(node, scope)
          overwrite = args[2].nil? ? true : args[2].as_boolean.is_a?(Yugo::Ruby::True)
          method    = overwrite ? :merge! : :merge
          Yugo::Ruby::MethodResolution.new(
            args[0],
            Yugo::Ruby::MethodCall.new(
              Yugo::Ruby::Identifier.new(method), [args[1]])
          )
        },
        findnocase: -> (node, scope) {
          args = Yugo::CFML.function_arguments(node, scope)
          substr = Yugo::Ruby::MethodResolution.new(args[0], Yugo::Ruby::Identifier.new(:downcase))
          args_ = if args.length == 3
                    [substr, args[2]]
                  else
                    [substr]
                  end

          ast = Yugo::Ruby::MethodResolution.new(
            Yugo::Ruby::MethodResolution.new(args[1], Yugo::Ruby::Identifier.new(:downcase)),
            Yugo::Ruby::MethodCall.new(Yugo::Ruby::Identifier.new(:index), args_))

          if scope.context != :boolean
            Yugo::Ruby::BinaryOperation.new(
              Yugo::Ruby::Operator.new(:'||'), ast, Yugo::Ruby::Integer.new(0))
          else
            ast
          end
        },
        find: -> (node, scope) {
          args = Yugo::CFML.function_arguments(node, scope)
          args_ = if args.length == 3
                    [args[0], args[2]]
                  else
                    [args[0]]
                  end

          ast = Yugo::Ruby::MethodResolution.new(
            args[1],
            Yugo::Ruby::MethodCall.new(
              Yugo::Ruby::Identifier.new(:index), args_)
          )

          if scope.context != :boolean
            Yugo::Ruby::BinaryOperation.new(
              Yugo::Ruby::Operator.new(:'||'),
              ast,
              Yugo::Ruby::Integer.new(0)
            )
          else
            ast
          end
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
