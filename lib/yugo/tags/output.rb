module Yugo
  module Tags
    class Output
      def initialize(attributes, content)
        @attributes = attributes
        @content = content
      end

      def compile
        @content.compile
      end
    end
  end
end