module Yugo
  module CFML
    class Super < Node
      def ruby_ast(_scope)
        Yugo::Ruby::Send.new(
          Yugo::Ruby::Identifier.from(:self),
          Yugo::Ruby::Identifier.from(:class))
      end
    end
  end
end
