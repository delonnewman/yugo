module Yugo
  module CFML
    module FunctionMacros
      module RuntimeFunctions
        def getbasetemplatepath
          Yugo::Ruby::Macro.new(Yugo::Ruby::Identifier.new(:template_path))
        end
  
        # TODO: translate arguments to defined?
        def isdefined(node, scope)
          args = Yugo::CFML.function_arguments(node, scope)
          Yugo::Ruby::MethodCall.new(
            Yugo::Ruby::Identifier.new(:defined?), args)
        end
      end
    end
  end
end
