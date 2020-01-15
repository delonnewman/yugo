module Yugo
  module Ruby
    class FunctionApplication < Send
      attr_reader :identifier, :arguments

      Contract Syntax, C::ArrayOf[Syntax] => C::Any
      def initialize(identifier, arguments = [])
        super(nil, identifier, arguments)
      end
    end
  end
end
