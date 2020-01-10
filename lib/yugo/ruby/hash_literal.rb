module Yugo
  module Ruby
    class HashLiteral < Syntax
      attr_reader :members

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

      def compile
        seperator = symbol_keys? ? ':' : ' =>'
        kvs = members.map { |(key, value)| "#{compile_key(key)}#{seperator} #{value.compile}" }.join(', ')
        if include_braces?
          "{" + kvs + "}"
        else
          kvs
        end
      end

      def to_sexp
        [:hash] + members.map(&:to_sexp)
      end

      def compile_key(key)
        case key
        when Yugo::Ruby::Symbol
          key.value
        else
          key.compile
        end
      end
    end
  end
end
