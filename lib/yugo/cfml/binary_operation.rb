module Yugo
  module CFML
    class BinaryOperation < Node
      def ruby_ast(scope)
        op    = elements[2]
        left  = elements[0]
        right = elements[4]
        case op
        when ContainsOperator
          contains_operator(left, right, scope)
        when EqualOperator
          equal_operator(op, left, right, scope)
        else
          binary_operator(op, left, right, scope)
        end
      end

      def contains_operator(left, right, scope)
        Yugo::Ruby::Send.new(
          left.ruby_ast(scope),
          Yugo::Ruby::Identifier.from(:include?),
          [right.ruby_ast(scope)]
        )
      end

      def equal_operator(op, left, right, scope)
        if left.is_a?(CFML::Null)
          Yugo::Ruby::Send.new(
            right.ruby_ast(scope),
            Yugo::Ruby::Identifier.from(:nil?))
        elsif right.is_a?(CFML::Null)
          Yugo::Ruby::Send.new(
            left.ruby_ast(scope),
            Yugo::Ruby::Identifier.from(:nil?))
        else
          binary_operator(op, left, right, scope)
        end
      end

      def binary_operator(op, left, right, scope)
        Yugo::Ruby::BinaryOperation.new(op.ruby_ast(scope), left.ruby_ast(scope), right.ruby_ast(scope))
      end
    end
  end
end
