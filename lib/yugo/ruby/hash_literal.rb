module Yugo
  module Ruby
    class HashLiteral < Syntax
      attr_reader :members

      Contract C::RespondTo[:to_h], C::KeywordArgs[include_braces: C::Bool, symbol_keys: C::Bool] => C::Any
      def initialize(members, include_braces: true, symbol_keys: false)
        @members = members
        @include_braces = include_braces
        @symbol_keys = symbol_keys
      end

      def symbol_keys?
        @symbol_keys
      end

      def include_braces?
        @include_braces
      end

      def to_sexp
        s(:hash, *members.map { |(key, value)| s(:pair, key.to_sexp, value.to_sexp) })
      end
    end
  end
end
