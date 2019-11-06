module Yugo
  module Ruby
    class Syntax
      def initialize(template)
        @template = template
      end

      def compile
        ERB.new(@template).result(binding)
      end
    end
  end
end