module Yugo
  module Ruby
    class Assignment < Syntax
      TEMPLATE = <<-RUBY
        <%= assignee.compile %> = <%= assigned.compile %>
      RUBY

      attr_reader :assignee
      attr_reader :assigned

      def initialize(assignee, assigned)
        @assignee = assignee
        @assigned = assigned
      end

      def compile
        super(TEMPLATE)
      end

      def to_sexp
        [:assignment, @assignee.to_sexp, @assigned.to_sexp]
      end
    end
  end
end
