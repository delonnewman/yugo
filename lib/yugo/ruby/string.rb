module Yugo
  module Ruby
    class String < SelfEvaluating
      def as_boolean
        case @value.downcase
        when 'no', 'false'
          Yugo::Ruby::False.instance
        when 'yes', 'true'
          Yugo::Ruby::True.instance
        else
          self
        end
      end

      def as_ruby_boolean
        case @value.downcase
        when 'no', 'false'
          false
        when 'yes', 'true'
          true
        else
          nil
        end
      end

      def as_symbol
        @value.downcase.to_sym
      end

      def as_syntax_symbol
        Yugo::Ruby::Symbol.new(as_symbol)
      end

      def as_identifier
        Yugo::Ruby::Identifier.from(as_symbol)
      end

      def as_instance_variable
        Yugo::Ruby::InstanceVariable.new(as_identifier)
      end

      def as_constant
        @value.split('.').reduce(nil) do |const, part|
          Yugo::Ruby::Constant.new(const, Yugo::Ruby::Identifier.from(part.capitalize))
        end
      end

      def as_method_access
        obj, method = @value.split('.')
        Yugo::Ruby::MethodResolution.new(
          Yugo::Ruby::Identifier.from(obj.downcase.to_sym),
          Yugo::Ruby::Identifier.from(method.downcase.to_sym))
      end

      def method_access?
        !!@value.index('.')
      end

      def to_sexp
        s(:str, @value)
      end
    end
  end
end
