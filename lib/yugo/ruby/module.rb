module Yugo
  module Ruby
    class Module < Syntax
      attr_reader :name, :body

      Contract Constant, Ruby::Program => C::Any
      def initialize(name, body)
        @name = name
        @body = body
      end

      def to_sexp
        s(:module, @name.to_sexp, body.to_sexp)
      end
    end
  end
end
