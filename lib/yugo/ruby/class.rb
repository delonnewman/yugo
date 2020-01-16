module Yugo
  module Ruby
    class Class < Syntax
      attr_reader :name, :parent, :body

      Contract Constant, Ruby::Program, C::Maybe[Constant] => C::Any
      def initialize(name, body, parent = nil)
        @name = name
        @body = body
        @parent = parent
      end

      def to_sexp
        s(:class, @name.to_sexp, @parent&.to_sexp, body.to_sexp)
      end
    end
  end
end
