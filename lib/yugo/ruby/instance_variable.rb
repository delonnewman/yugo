module Yugo
  module Ruby
    class InstanceVariable < Syntax
      attr_reader :name

      def initialize(name)
        @name = name
      end

      def compile
        "@#{@name.compile}"
      end

      def to_sexp
        [:instance_varaible, @name.to_sexp]
      end
    end
  end
end
