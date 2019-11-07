module Yugo
  module CFML
    class Content < Node
      def compile
        elements.map(&:compile).join('')
      end
    end
  end
end