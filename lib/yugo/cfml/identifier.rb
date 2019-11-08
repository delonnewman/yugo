module Yugo
  module CFML
    class Identifier < Node
      def ruby_ast(scope)
        name = text_value.downcase
        if scope.variable_exists?(name) and scope.top_level?
          Yugo::Ruby::InstanceVariable.new(Yugo::Ruby::Identifier.new(name))
        elsif scope.variable_exists?(name)
          Yugo::Ruby::BlockVariable.new(Yugo::Ruby::Identifier.new(name))
        else
          raise "Variable #{text_value} is undefined."
        end
      end
    end
  end
end
