module Yugo
  module Ruby
    class HashLiteral < Syntax
      attr_reader :members

      def initialize(members, include_braces: true)
        @members = members
        @include_braces = include_braces
      end

      def compile
        kvs = @members.map { |(key, value)| "#{key.compile} => #{value.compile}" }.join(', ')
        if @include_braces
          "{" + kvs + "}"
        else
          kvs
        end
      end

      def to_sexp
        [:hash] + @members.map(&:to_sexp)
      end
    end
  end
end
