module Yugo
  module CFML
    class Null < Node
      def ruby_ast
        Yugo::Ruby::Nil.new
      end
    end
  end
end