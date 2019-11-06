module Yugo
  module Ruby
    class ArrayLiteral < Syntax
      attr_reader :members

      def initialize(members)
        @members = members
      end

      def compile
        "[" << @members.map(&:compile).join(', ') << "]"
      end
    end
  end
end
