module Yugo
  module CFML
    module FunctionMacros
      module ListFunctions
        def lastlist(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          Yugo::Ruby::Send.new(
            Yugo::Ruby::Send.new(
              args[0],
              Yugo::Ruby::Identifier.from(:split),
              [args[1] || Yugo::Ruby::String.new(',')]
            ),
            Yugo::Ruby::Identifier.from(:last)
          )
        end

        def listfind(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          ast = Yugo::Ruby::Send.new(
            Yugo::Ruby::Send.new(
              args[0],
              Yugo::Ruby::Identifier.from(:split),
              [args[2] || Yugo::Ruby::String.new(',')]
            ),
            Yugo::Ruby::Identifier.from(:index),
            [args[1]]
          )
  
          if not scope.boolean_context?
            Yugo::Ruby::BinaryOperation.new(
              Yugo::Ruby::Operator.new(:'||'),
              ast,
              Yugo::Ruby::Integer.new(0)
            )
          else
            ast
          end
        end
      end
    end
  end
end
