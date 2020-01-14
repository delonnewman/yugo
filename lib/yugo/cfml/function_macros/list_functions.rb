module Yugo
  module CFML
    module FunctionMacros
      module ListFunctions
        def lastlist(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          Yugo::Ruby::MethodResolution.new(
            Yugo::Ruby::MethodResolution.new(
              args[0],
              Yugo::Ruby::MethodCall.new(
                Yugo::Ruby::Identifier.from(:split), [args[1] || Yugo::Ruby::String.new(',')])
            ),
            Yugo::Ruby::Identifier.from(:last)
          )
        end

        def listfind(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          ast = Yugo::Ruby::MethodResolution.new(
            Yugo::Ruby::MethodResolution.new(
              args[0],
              Yugo::Ruby::MethodCall.new(
                Yugo::Ruby::Identifier.from(:split), [args[2] || Yugo::Ruby::String.new(',')])
            ),
            Yugo::Ruby::Identifier.from(:index),
            [args[1]]
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
        end
      end
    end
  end
end
