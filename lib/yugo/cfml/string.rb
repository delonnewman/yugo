module Yugo
  module CFML
    class String < Node
      def ruby_ast(scope)
        elems = evaluate_elements(elements)
        p elems
        Yugo::Ruby::String.new(elems.join(''))
      end

      def evaluate_elements(elements)
        if elements
          []
        else
          elements.map do |elem|
            p elem
            case elem
            when Yugo::CFML::Quote
              elem.ruby_ast(scope).compile
            else
              evaluate_elements(elem.elements)
            end
          end
        end
      end
    end
  end
end
