module Yugo
  module Ruby
    class Class < Syntax
      attr_reader :name, :parent, :methods

      Contract Identifier, C::ArrayOf[Method], C::Maybe[Identifier] => C::Any
      def initialize(name, methods, parent = nil)
        @name = name
        @methods = methods
        @parent = parent
      end

      def to_sexp
        meths = @methods.empty? ? s(:nil) : methods.map(&:to_sexp)
        s(:class, @name.to_sexp, @parent, meths)
      end
    end
  end
end
