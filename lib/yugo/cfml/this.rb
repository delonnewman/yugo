module Yugo
  module CFML
    class This < Node
      def ruby_ast(_scope)
        Yugo::Ruby::Self.new
      end
    end
  end
end
