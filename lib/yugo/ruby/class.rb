module Yugo
  module Ruby
    class Class < Syntax
      TEMPLATE = <<-RUBY
        <%- if parent -%>
        class <%= name.compile %> < <%= parent.compile %>
        <%- else -%>
        class <%= name.compile %>
        <%- end -%>
        <%- methods.each do |method| -%>
          method.compile
        <%- end -%>
        end
      RUBY

      attr_reader :name, :parent, :methods

      def initialize(name, methods, parent = nil)
        super(TEMPLATE)
        @name = name
        @methods = methods
        @parent = parent
      end
    end
  end
end