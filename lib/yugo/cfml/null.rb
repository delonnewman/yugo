module Yugo
  module CFML
    class Null < Node
      def ruby_ast(_scope)
        Yugo::Ruby::Nil.new
      end
    end
  end
end
