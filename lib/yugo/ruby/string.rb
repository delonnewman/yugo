module Yugo
  module Ruby
    class String < SelfEvaluating
      def compile
        @value.to_json
      end
    end
  end
end
