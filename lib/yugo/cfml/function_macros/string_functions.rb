module Yugo
  module CFML
    module FunctionMacros
      module StringFunctions
        def findnocase(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          substr = Yugo::Ruby::MethodResolution.new(args[0], Yugo::Ruby::Identifier.from(:downcase))
          args_ = if args.length == 3
                    [substr, args[2]]
                  else
                    [substr]
                  end
  
          ast = Yugo::Ruby::MethodResolution.new(
            Yugo::Ruby::MethodResolution.new(args[1], Yugo::Ruby::Identifier.from(:downcase)),
            Yugo::Ruby::MethodCall.new(Yugo::Ruby::Identifier.from(:index), args_))
  
          if scope.context != :boolean
            Yugo::Ruby::BinaryOperation.new(
              Yugo::Ruby::Operator.new(:'||'), ast, Yugo::Ruby::Integer.new(0))
          else
            ast
          end
        end
  
        def find(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          args_ = if args.length == 3
                    [args[0], args[2]]
                  else
                    [args[0]]
                  end
  
          ast = Yugo::Ruby::MethodResolution.new(
            args[1],
            Yugo::Ruby::MethodCall.new(
              Yugo::Ruby::Identifier.from(:index), args_)
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
