module Yugo
  module CFML
    class VariableScope
      attr_reader :context, :variables

      def initialize(parent = nil, context = nil)
        @parent    = parent
        @variables = {}
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
        if @variables.key?(name)
          true
        elsif @parent
          @parent.variable_exists?(name)
        else
          false
        end
      end

      def lookup(name)
        if @variables.key?(name)
          self
        elsif @parent
          @parent.lookup(name)
        else
          nil
        end
      end

      def add_variable(name, syntax)
        @variables[name] = syntax
      end
    end
  end
end
