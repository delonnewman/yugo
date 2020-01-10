module Yugo
  module CFML
    class Identifier < Node
      SPECIAL_IDENTIFIERS = (%i[evaluate].to_set + Yugo::Runtime.instance_methods(false).to_set).freeze

      def ruby_ast(scope, resolve_identifiers: true)
        ident = Yugo::Ruby::Identifier.new(symbol)
        if scope.nil?
          ident
        elsif (scope_ = scope.lookup(symbol)) and scope_.top_level?
          Yugo::Ruby::InstanceVariable.new(ident)
        elsif scope.variable_exists?(symbol) or SPECIAL_IDENTIFIERS.include?(symbol)
          Yugo::Ruby::BlockVariable.new(ident)
        else
          Yugo::CFML.logger.info "#{inspect}"
          if resolve_identifiers
            raise "Variable #{text_value} is undefined."
          else
            ident
          end
        end
      end

      def as_symbol
        Yugo::Ruby::Symbol.new(symbol)
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
