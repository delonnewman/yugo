module Yugo
  module CFML
    class Content < Node
      include Yugo::Utils

      def ruby_ast(scope)
        nodes = elements
                  .flat_map { |elem| evaluate_element(elem, scope) }
                  .reject(&:nil?)

        if scope.query_scope?
          Yugo::Ruby::String.new(nodes.map(&:text).join(''))
        elsif scope.erb_context?
          Yugo::ERB::Content.new(nodes)
        else
          Yugo::Ruby::Program.new(nodes)
        end
      end

      def evaluate_element(elem, scope)
        if elem.is_a?(Quote)
          Yugo::ERB::OutputTag.new(elem.ruby_ast(scope))
        elsif plain_node?(elem) and elements_present?(elem)
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
