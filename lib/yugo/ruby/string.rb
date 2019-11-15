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
    end
  end
end
