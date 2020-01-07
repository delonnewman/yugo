module Yugo
  module CFML
    class Identifier < Node
      SPECIAL_IDENTIFIERS = (%i[evaluate].to_set + Yugo::Runtime.instance_methods(false).to_set).freeze

      def ruby_ast(scope)
        if scope.nil?
          Yugo::Ruby::Identifier.new(symbol)
        elsif (scope_ = scope.lookup(symbol)) and scope_.top_level?
          Yugo::Ruby::InstanceVariable.new(Yugo::Ruby::Identifier.new(symbol))
        elsif scope.variable_exists?(symbol) or SPECIAL_IDENTIFIERS.include?(symbol)
          Yugo::Ruby::BlockVariable.new(Yugo::Ruby::Identifier.new(symbol))
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
      alias symbol to_sym
    end
  end
end
