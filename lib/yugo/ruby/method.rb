module Yugo
  module Ruby
    class Method < Syntax
      TEMPLATE = <<-RUBY
        def <%= name.compile %>(<%= arguments.map(&:compile).join(', ') %>)
          <% body.each do |line| %>
          <%= line.compile %>
          <% end %>
        end
      RUBY

      attr_reader :name, :arguments, :body

      Contract Identifier, C::ArrayOf[Ruby::Syntax], C::ArrayOf[C::Or[Ruby::Syntax, Yugo::ERB::Syntax]] => C::Any
      def initialize(name, arguments, body)
        @name = name
        @arguments = arguments
        @body = body
      end

      def compile
        "<% #{super(TEMPLATE)} %>"
      end

      def to_sexp
        [:method, @name.to_sexp, @arguments.map(&:to_sexp)] + @body.map(&:to_sexp)
      end
    end
  end
end
