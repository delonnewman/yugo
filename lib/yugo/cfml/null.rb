module Yugo
  module CFML
    class Null < Node
      def ruby_ast(_scope)
        Yugo::Ruby::Nil.instance
      end
    end
  end
end
