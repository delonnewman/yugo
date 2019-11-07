module Yugo
  module ERB
    class RubyCode < Syntax
      def initialize(expressions)
        @expressions = expressions
      end

      def compile
        @expressions.map(&:compile).join('')
      end
    end
  end
end