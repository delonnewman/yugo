module Yugo
  module Ruby
    class HashLiteral < Syntax
      attr_reader :members

      def initialize(members)
        @members = members
      end

      def compile
        "{" << @members.map { |(key, value)| "#{key.compile} => #{value.compile}" }.join(', ') << "}"
      end
    end
  end
end