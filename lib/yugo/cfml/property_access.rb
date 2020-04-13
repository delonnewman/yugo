module Yugo
  module CFML
    class PropertyAccess < Node
      def ruby_ast(scope)
        object = head.ruby_ast(scope)
        if tail.empty?
          object
        else
          tail.elements.reduce(object) do |obj, elem|
            puts "#{elem.class} - #{elem.text_value}"
            Yugo::Ruby::Send.new(obj, elem.elements[3].property.ruby_ast(scope, resolve_identifiers: false))
          end
        end
      end
    end
  end
end
