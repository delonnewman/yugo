module Yugo
  module CFML
    class BinaryOperation < Node
      def ruby_ast
        op    = elements[2]
        left  = elements[0]
        right = elements[4]
        if op.method_call?
          case op
          when ContainsOperator
            Yugo::Ruby::MethodResolution.new(
                left.ruby_ast,
                Yugo::Ruby::Identifier.new("include?"),
                [right.ruby_ast]
            )
          else
            raise Yugo::TypeError, "Don't know how to build a Ruby AST for #{op.inspect}"
          end
        else
          Yugo::Ruby::BinaryOperation.new(op.ruby_ast, left.ruby_ast, right.ruby_ast)
        end
      end
    end
  end
end