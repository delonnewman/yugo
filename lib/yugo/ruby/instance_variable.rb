module Yugo
  module Ruby
    class InstanceVariable < Syntax
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def compile
        "@#{@name}"
      end
    end
  end
end