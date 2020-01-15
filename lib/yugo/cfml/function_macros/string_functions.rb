module Yugo
  module CFML
    module FunctionMacros
      module StringFunctions
        def findnocase(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          substr = Yugo::Ruby::Send.new(args[0], Yugo::Ruby::Identifier.from(:downcase))
          args_ = if args.length == 3
                    [substr, args[2]]
                  else
                    [substr]
                  end
  
          ast = Yugo::Ruby::Send.new(
                  Yugo::Ruby::Send.new(args[1], Yugo::Ruby::Identifier.from(:downcase)),
                  Yugo::Ruby::Identifier.from(:index), args_)
  
          if not scope.boolean_context?
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
  
          ast = Yugo::Ruby::Send.new(args[1], Yugo::Ruby::Identifier.from(:index), args_)
  
          if not scope.boolean_context?
            Yugo::Ruby::BinaryOperation.new(Yugo::Ruby::Operator.new(:'||'), ast, Yugo::Ruby::Integer.new(0))
          else
            ast
          end
        end
      end
    end
  end
end
