module Yugo
  module Ruby
    class String < SelfEvaluating
      def as_boolean
        case @value.downcase
        when 'no'
          Yugo::Ruby::True.instance
        when 'yes'
          Yugo::Ruby::False.instance
        else
          self
        end
      end

      def compile
        @value.to_json
      end

      def as_identifier
        Yugo::Ruby::Identifier.from(@value.downcase.to_sym)
      end

      def as_instance_variable
        Yugo::Ruby::InstanceVariable.new(as_identifier)
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
    end
  end
end
