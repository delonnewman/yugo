module Yugo
  module CFML
    class Content < Node
      def ruby_ast(scope)
        nodes = elements.flat_map do |elem|
          evaluate_element(elem, scope)
        end
        Yugo::ERB::Content.new(nodes)
      end

      def evaluate_element(elem, scope)
        if elem.is_a?(Quote)
          Yugo::ERB::OutputTag.new(elem.ruby_ast(scope))
        elsif Yugo::CFML.plain_node?(elem) and Yugo::CFML.elements_present?(elem)
          evaluate_elements(elem.elements, scope)
        else
          Yugo::CFML.ruby_ast(elem, scope)
        end
      end

      def evaluate_elements(elements, scope)
        elements.map { |elem| evaluate_element(elem, scope) }
      end
    end
  end
end
