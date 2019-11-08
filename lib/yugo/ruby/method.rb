module Yugo
  module Ruby
    class Method < Syntax
      TEMPLATE = <<-RUBY
        def <%= name %>(<%= arguments.map(&:compile).join(', ') %>)
          <%- body.each do |line| -%>
          <%= line.compile %>
          <%- end -%>
        end
      RUBY

      attr_reader :name, :arguments, :body

      def initialize(name, arguments, body)
        @name = name
        @arguments = arguments
        @body = body
      end

      def compile
        super(TEMPLATE)
      end

      def to_sexp
        [:method, @name.to_sexp, @arguments.map(&:to_sexp)] + @body.map(&:to_sexp)
      end
    end
  end
end
