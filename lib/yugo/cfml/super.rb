module Yugo
  module CFML
    class Super < Node
      def ruby_ast(_scope)
        Yugo::Ruby::MethodResolution.new(
          Yugo::Ruby::Identifier.new(:self),
          Yugo::Ruby::MethodCall.new(
            Yugo::Ruby::Identifier.new(:class)))
      end
    end
  end
end
