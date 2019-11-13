module Yugo
  module Ruby
    class Macro < Syntax
      TEMPLATE = <<-RUBY
        <% if arguments.empty? %>
          <%= identifier.compile %>
        <% else %>
          <%= identifier.compile %> <%= arguments.map(&:compile).join(', ') %>
        <% end %>
      RUBY

      attr_reader :identifier, :arguments

      def initialize(identifier, arguments = [])
        @identifier = identifier
        @arguments = arguments
      end

      def compile
        super(TEMPLATE)
      end

      def to_sexp
        [@identifier.to_sexp] + @arguments.map(&:to_sexp)
      end
    end
  end
end