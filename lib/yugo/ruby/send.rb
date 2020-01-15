module Yugo
  module Ruby
    class Send < Syntax
      attr_reader :object, :method_name, :arguments

      Contract C::Maybe[Syntax], Syntax, C::ArrayOf[Syntax] => C::Any
      def initialize(object, method_name, arguments = [])
        @object = object
        @method_name = method_name
        @arguments = arguments
      end

      def to_sexp
        s(:send, @object&.to_sexp, @method_name.to_sexp, *@arguments.map(&:to_sexp))
      end
    end
  end
end
