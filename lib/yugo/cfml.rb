require 'treetop'
require_relative 'cfml/parser'

module Yugo
  module CFML
    class Base < Treetop::Runtime::SyntaxNode
    end

    class Text < Base
    end

    class Comment < Base
      def content
        elements[1].text_value
      end
      alias to_s content
    end

    class Quote < Base
    end

    class StringLiteral < Base
    end

    class BooleanLiteral < Base
    end

    class NullLiteral < Base
    end

    class IntegerLiteral < Base
    end

    class FloatLiteral < Base
    end

    class BinaryOperation < Base
    end

    class UnaryOperation < Base
    end

    # Operators

    class AdditionOperator < Base
    end

    class SubtractionOperator < Base
    end

    class MultiplicationOperator < Base
    end

    class DivisionOperator < Base
    end

    class ExponentOperator < Base
    end

    class ModulusOperator < Base
    end

    class EqualOperator < Base
    end

    class NotEqualOperator < Base
    end

    class ContainsOperator < Base
    end

    class DoesNotContainOperator < Base
    end

    class GreaterThanOperator < Base
    end

    class GreaterThanOrEqualToOperator < Base
    end

    class LessThanOperator < Base
    end

    class LessThanOrEqualToOperator < Base
    end

    class AndOperator < Base
    end

    class OrOperator < Base
    end

    class XorOperator < Base
    end

    class NotOperator < Base
    end

    class EqvOperator < Base
    end

    class ImpOperator < Base
    end

    class Identifier < Base
    end

    class FunctionApplication < Base
    end

    class ContentTag < Base
    end

    class EmptyTag
    end

    class OpenTag < Base
    end

    class CloseTag < Base
    end

    class Attribute < Base
    end

    class Content < Base
    end

    class Expression < Base
    end
  end
end
