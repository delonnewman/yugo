module Yugo
  module Ruby
    class Assignment < Syntax
      TEMPLATE = <<-RUBY
        <%= assignee.compile %> <%= operator.to_s %> <%= assigned.compile %>
      RUBY

      OPERATORS = %i[= += -= ||= &&=].to_set.freeze
      Operator = -> (val) { OPERATORS.include?(val) }

      attr_reader :assignee, :assigned, :operator

      Contract Syntax, Syntax, C::Maybe[Operator] => C::Any
      def initialize(assignee, assigned, operator = :'=')
        @assignee = assignee
        @assigned = assigned
        @operator = operator
      end

      def compile
        super(TEMPLATE)
      end

      def to_sexp
        [@operator, @assignee.to_sexp, @assigned.to_sexp]
      end
    end
  end
end
