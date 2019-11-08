module Yugo
  module CFML
    class Content < Node
      def ruby_ast
        nodes = elements.flat_map do |elem|
          evaluate_element(elem)
        end
        Yugo::ERB::Content.new(nodes)
      end

      def evaluate_element(elem)
        if elem.is_a?(Quote)
          Yugo::ERB::OutputTag.new(elem.ruby_ast)
        elsif Yugo::CFML.plain_node?(elem) and Yugo::CFML.elements_present?(elem)
          evaluate_elements(elem.elements)
        else
          Yugo::CFML.ruby_ast(elem)
        end
      end

      def evaluate_elements(elements)
        elements.map { |elem| evaluate_element(elem) }
      end
    end
  end
end
