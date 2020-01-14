module Yugo
  module CFML
    module FunctionMacros
      module RuntimeFunctions
        def getbasetemplatepath
          Yugo::Ruby::Macro.new(Yugo::Ruby::Identifier.from(:template_path))
        end
  
        # TODO: translate arguments to defined?
        def isdefined(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          Yugo::Ruby::MethodCall.new(
            Yugo::Ruby::Identifier.from(:defined?), args)
        end
      end
    end
  end
end
