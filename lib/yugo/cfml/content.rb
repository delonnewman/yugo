module Yugo
  module CFML
    class Content < Node
      def ruby_ast
        nodes = elements.map do |elem|
          case elem
          when Quote
            Yugo::ERB::OutputTag.new(elem.ruby_ast)
          else
            Yugo::CFML.ruby_ast(e)
          end
        end
        Yugo::ERB::Content.new(nodes)
      end
    end
  end
end