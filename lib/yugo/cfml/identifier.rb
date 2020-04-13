module Yugo
  module CFML
    class Identifier < Node
      SPECIAL_IDENTIFIERS = (%i[evaluate].to_set + Yugo::Runtime.instance_methods(false).to_set).freeze

      def ruby_ast(scope, resolve_identifiers: true)
        sym = symbol(resolve_identifiers)
        ident = Yugo::Ruby::Identifier.from(sym)
        if scope.nil?
          ident
        elsif (scope_ = scope.lookup(sym)) and scope_.top_level?
          var = scope_.variables[sym]
          if var.is_a?(Yugo::Ruby::Method)
            ident
          else
            Yugo::Ruby::InstanceVariable.new(ident)
          end
        elsif scope.variable_exists?(sym) or SPECIAL_IDENTIFIERS.include?(sym)
          Yugo::Ruby::BlockVariable.new(ident)
        else
          Yugo::CFML.logger.info "#{inspect}"
          if resolve_identifiers
            raise "Variable #{text_value} is undefined."
          else
            ident.as_symbol
          end
        end
      end

      def as_symbol(*args)
        Yugo::Ruby::Symbol.new(symbol(*args))
      end

      def name(downcase = true)
        if downcase
          text_value.downcase
        else
          text_value
        end
      end

      def to_sym(*args)
        name(*args).to_sym
      end
      alias symbol to_sym
    end
  end
end
