module Yugo
  module Ruby
    class MethodCall < Syntax
      TEMPLATE = <<-RUBY
        <% if arguments.empty? %>
          <%= identifier.compile %>
        <% else %>
          <%= identifier.compile %>(<%= arguments.map(&:compile).join(', ') %>)
        <% end %>
      RUBY

      attr_reader :identifier, :arguments

      Contract Syntax, C::ArrayOf[Syntax] => C::Any
      def initialize(identifier, arguments = [])
        @identifier = identifier
        @arguments = arguments
      end

      def compile
        super(TEMPLATE)
      end

      def to_sexp
        if @arguments.empty?
          [@identifier.to_sexp]
        else
          [@identifier.to_sexp] + @arguments.map(&:to_sexp)
        end
      end
    end
  end
end
