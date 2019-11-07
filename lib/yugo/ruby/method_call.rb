module Yugo
  module Ruby
    class MethodCall < Syntax
      TEMPLATE = <<-RUBY
        <%= identifier.compile %>(<%= arguments.map(&:compile).join(', ') %>)
      RUBY

      attr_reader :identifier, :arguments

      def initialize(identifier, arguments)
        super(TEMPLATE)
        @identifier = identifier
        @arguments = arguments
      end
    end
  end
end