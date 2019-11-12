module Yugo
  module CFML
    class PropertyAccess < Node
      def ruby_ast(scope)
        if respond_to?(:identifier1) and respond_to?(:identifier2)
          Yugo::Ruby::MethodResolution.new(identifier1.ruby_ast(scope), identifier2.ruby_ast(nil))
        elsif respond_to?(:property_access)
          Yugo::Ruby::MethodResolution.new(identifier.ruby_ast(scope), property_access.ruby_ast(nil))
        elsif respond_to?(:function_application)
          Yugo::Ruby::MethodCall.new(
            Yugo::Ruby::MethodResolution.new(identifier.ruby_ast(scope), function_application.identifier.ruby_ast(nil)),
            Yugo::CFML.function_arguments(function_application, scope)
          )
        else
          raise "Don't know how to process this property access: #{text_value}"
        end
      end
    end
  end
end
