module Yugo
  module CFML
    class IfTag < Node
      def ruby_ast
        nodes = elements.flat_map do |elem|
          text = elem.text_value.downcase
          case text
          when /^<cfif/
            Yugo::ERB::StatementTag.new(Yugo::Ruby::IfClause.new(elem.expression.ruby_ast))
          when /^<\/cfif>/
            Yugo::ERB::StatementTag.new(Yugo::Ruby::End.new)
          when /^<cfelseif/
            [Yugo::ERB::StatementTag.new(Yugo::Ruby::ElsifClause.new(elem.elements.first.expression.ruby_ast)), elem.elements[1].ruby_ast]
          when /^<cfelse/
            [Yugo::ERB::StatementTag.new(Yugo::Ruby::Else.new), elem.elements[1].ruby_ast]
          else
            Yugo::CFML.ruby_ast(elem)
          end
        end
        Yugo::ERB::Content.new(nodes)
      end
    end
  end
end
