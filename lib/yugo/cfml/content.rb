module Yugo
  module CFML
    class Content < Node
      def ruby_ast(scope)
        nodes = elements.flat_map do |elem|
          evaluate_element(elem, scope)
        end.reject(&:nil?)
        if scope.erb_context?
          Yugo::ERB::Content.new(nodes)
        else
          Yugo::Ruby::Program.new(nodes)
        end
      end

      def evaluate_element(elem, scope)
        if elem.is_a?(Quote)
          Yugo::ERB::OutputTag.new(elem.ruby_ast(scope))
        elsif Yugo::Utils.plain_node?(elem) and Yugo::Utils.elements_present?(elem)
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
