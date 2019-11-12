module Yugo
  module CFML
    class VariableScope
      def initialize(parent = nil, variables = Set.new)
        @parent = nil
        @variables = variables.to_set
      end

      def top_level?
        @parent.nil?
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
