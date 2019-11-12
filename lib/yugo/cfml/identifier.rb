module Yugo
  module CFML
    class Identifier < Node
      SPECIAL_IDENTIFIERS = (%w[evaluate].to_set + Yugo::Runtime.instance_methods(false).map(&:to_s).to_set).freeze

      def ruby_ast(scope)
        name = text_value.downcase
        if scope.nil?
          Yugo::Ruby::Identifier.new(name)
        elsif scope.variable_exists?(name) and scope.top_level?
          Yugo::Ruby::InstanceVariable.new(Yugo::Ruby::Identifier.new(name))
        elsif scope.variable_exists?(name) or SPECIAL_IDENTIFIERS.include?(name)
          Yugo::Ruby::BlockVariable.new(Yugo::Ruby::Identifier.new(name))
        else
          Yugo::CFML.logger.info "#{inspect}"
          raise "Variable #{text_value} is undefined."
        end
      end
    end
  end
end
