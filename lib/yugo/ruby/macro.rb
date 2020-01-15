module Yugo
  module Ruby
    class Macro < Syntax
      attr_reader :identifier, :arguments

      Contract Identifier, C::ArrayOf[Syntax] => C::Any
      def initialize(identifier, arguments = [])
        @identifier = identifier
        @arguments = arguments
      end

      def to_sexp
        s(:send, nil, @identifier.to_sexp, *@arguments.map(&:to_sexp))
      end
    end
  end
end
