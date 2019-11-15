module Yugo
  module CFML
    class VariableScope
      attr_reader :context

      def initialize(parent = nil, context = nil)
        @parent    = parent
        @variables = Set.new
        @context   = context
      end

      def top_level?
        @parent.nil?
      end

      def in_boolean_context
        self.class.new(self, :boolean)
      end

      def in_numeric_context
        self.class.new(self, :numeric)
      end

      def variable_exists?(name)
        if @variables.include?(name)
          true
        elsif @parent
          @parent.variable_exists?(name)
        else
          false
        end
      end

      def add_variable_name(name)
        @variables << name
      end
    end
  end
end
