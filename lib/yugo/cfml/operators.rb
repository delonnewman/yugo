module Yugo
  module CFML
    class Operator < Node
      def method_call?
        false
      end
    end

    class AdditionOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:+)
      end
    end

    class MultiplicationOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:*)
      end
    end

    class SubtractionOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:-)
      end
    end

    class DivisionOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:/)
      end
    end

    class ExponentOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:**)
      end
    end

    class ModulusOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:%)
      end
    end

    class EqualOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:==)
      end
    end

    class NotEqualOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:!=)
      end
    end

    class GreaterThanOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:>)
      end
    end

    class GreaterThanOrEqualToOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:>=)
      end
    end

    class LessThanOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:<)
      end
    end

    class LessThanOrEqualToOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:<=)
      end
    end

    class AndOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:'&&')
      end
    end

    class OrOperator < Operator
      def ruby_ast
        Yugo::Ruby::Operator.new(:'||')
      end
    end

    class XorOperator < Operator
      def ruby_ast
        raise "Not implemented"
      end
    end

    class EqvOperator < Operator
      def ruby_ast
        raise "Not implemented"
      end
    end

    class ImpOperator < Operator
      def ruby_ast
        raise "Not implemented"
      end
    end

    class ConcatenationOperator < Operator
      def ruby_ast
        # TODO: may want to do some type checking here
        Yugo::Ruby::Operator.new(:+)
      end
    end

    class ContainsOperator < Operator
      def method_call?
        true
      end

      def ruby_ast
        raise "Not implemented"
      end
    end

    class DoesNotContainOperator < Operator
      def method_call?
        true
      end

      def ruby_ast
        raise "Not implemented"
      end
    end
  end
end