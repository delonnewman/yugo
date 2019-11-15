module Yugo
  module CFML
    class IfTag < Node
      def ruby_ast(scope)
        nodes = elements.flat_map do |elem|
          text = elem.text_value.downcase
          case text
          when /^<cfif/
            Yugo::ERB::StatementTag.new(Yugo::Ruby::IfClause.new(elem.expression.ruby_ast(scope.in_boolean_context)))
          when /^<\/cfif>/
            Yugo::ERB::StatementTag.new(Yugo::Ruby::End.new)
          when /^<cfelseif/
            [Yugo::ERB::StatementTag.new(Yugo::Ruby::ElsifClause.new(elem.elements.first.expression.ruby_ast(scope.in_boolean_context))), elem.elements[1].ruby_ast(scope)]
          when /^<cfelse/
            [Yugo::ERB::StatementTag.new(Yugo::Ruby::Else.new), elem.elements[1].ruby_ast(scope)]
          else
            Yugo::CFML.ruby_ast(elem, scope)
          end
        end
        Yugo::ERB::Content.new(nodes)
      end
    end
  end
end
