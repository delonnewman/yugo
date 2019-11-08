module Yugo
  module CFML
    class FunctionApplication < Node
      # TODO: add key/value arguments
      def ruby_ast(scope)
        args = function_arguments.elements.flat_map do |elem|
          if elem.respond_to?(:ruby_ast)
            elem.ruby_ast(scope)
          elsif !elem.elements.nil? and !elem.elements.empty?
            elem.elements.map { |e| e.expression.ruby_ast(scope) }
          else
            []
          end
        end
        Yugo::Ruby::MethodCall.new(
            identifier.ruby_ast(scope),
            args
        )
      end
    end
  end
end
