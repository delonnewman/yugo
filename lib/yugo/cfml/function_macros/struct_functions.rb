module Yugo
  module CFML
    module FunctionMacros
      module StructFunctions
        def structnew(node, scope)
          args = Yugo::CFML.function_arguments(node, scope)
          Yugo::Ruby::MethodResolution.new(
            Yugo::Ruby::Identifier.from(:'Yugo::Struct'),
            Yugo::Ruby::MethodCall.new(Yugo::Ruby::Identifier.from(:new), args)
          )
        end
  
        def structappend(node, scope)
          args      = Yugo::CFML.function_arguments(node, scope)
          overwrite = args[2].nil? ? true : args[2].as_boolean.is_a?(Yugo::Ruby::True)
          method    = overwrite ? :merge! : :merge
          Yugo::Ruby::MethodResolution.new(
            args[0],
            Yugo::Ruby::MethodCall.new(
              Yugo::Ruby::Identifier.from(method), [args[1]])
          )
        end
  
        def structclear(node, scope)
          args = Yugo::CFML.function_arguments(node, scope)
          Yugo::Ruby::MethodResolution.new(
            args[0],
            Yugo::Ruby::MethodCall.new(
              Yugo::Ruby::Identifier.from(:clear)))
        end
      end
    end
  end
end
