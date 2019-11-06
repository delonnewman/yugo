module Yugo
  module Ruby
    class Identifier < Syntax
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def compile
        @name.to_s
      end
    end
  end
end