module Yugo
  module Ruby
    class Assignment < Syntax
      OPERATORS = %i[+ - || &&].to_set.freeze
      Operator = -> (val) { OPERATORS.include?(val) }

      attr_reader :assignee, :assigned, :operator

      Contract Syntax, Syntax, C::Maybe[Operator] => C::Any
      def initialize(assignee, assigned, operator = nil)
        @assignee = assignee
        @assigned = assigned
        @operator = operator
      end

      def sexp_tag
        case @assignee
        when InstanceVariable
          :ivasgn
        when BlockVariable
          :lvasgn
        else
          raise "Invalid assignee"
        end
      end

      def assignee_sexp
        case @assignee
        when InstanceVariable, BlockVariable
          @assignee.symbol
        else
          @assignee.to_sexp
        end
      end

      def to_sexp
        if @operator
          s(:'op-asgn', s(sexp_tag, assignee_sexp), @assigned.to_sexp)
        else
          s(sexp_tag, assignee_sexp, @assigned.to_sexp)
        end
      end
    end
  end
end
