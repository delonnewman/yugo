module Yugo
  module Ruby
    class Boolean < SelfEvaluating; end
    class True < Boolean
      def initialize
        super('true')
      end
    end
    class False < Boolean
      def initialize
        super('false')
      end
    end
  end
end