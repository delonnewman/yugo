module Yugo
  module CFML
    class Identifier < Node
      SPECIAL_IDENTIFIERS = (%i[evaluate].to_set + Yugo::Runtime.instance_methods(false).to_set).freeze

      def ruby_ast(scope)
        if scope.nil?
          Yugo::Ruby::Identifier.new(name)
        elsif scope.variable_exists?(name) and scope.top_level?
          Yugo::Ruby::InstanceVariable.new(Yugo::Ruby::Identifier.new(name))
        elsif scope.variable_exists?(name) or SPECIAL_IDENTIFIERS.include?(to_sym)
          Yugo::Ruby::BlockVariable.new(Yugo::Ruby::Identifier.new(name))
        else
          Yugo::CFML.logger.info "#{inspect}"
          raise "Variable #{text_value} is undefined."
        end
      end

      def name
        @name ||= text_value.downcase
      end

      def to_sym
        @sym ||= name.to_sym
      end
    end
  end
end
