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
        super(TEMPLATE)
        @name = name
        @arguments = arguments
        @body = body
      end
    end
  end
end