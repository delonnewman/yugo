module Yugo
  module CFML
    class FunctionApplication < Node
      def ruby_ast
        args = function_arguments.elements.flat_map do |elem|
          if elem.respond_to?(:ruby_ast)
            elem.ruby_ast
          elsif !elem.elements.nil? and !elem.elements.empty?
            elem.elements.map { |e| e.expression.ruby_ast }
          else
            []
          end
        end
        Yugo::Ruby::MethodCall.new(
            identifier.ruby_ast,
            args
        )
      end
    end
  end
end