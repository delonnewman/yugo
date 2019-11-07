module Yugo
  module Tags
    class Set
      attr_reader :name, :value, :function_scope

      def initialize(assignment)
      end

      alias function_scope? function_scope

      def eval(env)
        if function_scope?
          env.arguments[name] = value
        else
          env.variables[name] = value
        end
      end

      def compile(env)
        if function_scope?
          "#{name.compile(env)} = #{value.compile(env)}"
        else
          # TODO: register with runtime also? or just there?
          "$#{name.compile(env)} = #{value.compile(env)}"
        end
      end
    end
  end
end
