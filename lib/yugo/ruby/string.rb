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
        Yugo::Ruby::Identifier.new(@value.downcase.to_sym)
      end
    end
  end
end
