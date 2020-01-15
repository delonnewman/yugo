module Yugo
  module CFML
    class IfTag < Node
      def ruby_ast(scope)
        nodes = elements.flat_map do |elem|
          text = elem.text_value.downcase
          case text
          when /^<cfif/
            if_clause(elem, scope)
          when /^<\/cfif>/
            end_if(scope)
          when /^<cfelseif/
            elseif_clause(elem, scope)
          when /^<cfelse/
            else_clause(elem, scope)
          else
            Yugo::CFML.ruby_ast(elem, scope)
          end
        end.reject(&:nil?)
        
        if scope.erb_context?
          Yugo::ERB::Content.new(nodes)
        else
          puts "NODES: #{nodes.map(&:class).inspect}"
          Yugo::Ruby::If.from(nodes)
        end
      end

      def if_clause(elem, scope)
        ast = Yugo::Ruby::IfClause.new(elem.expression.ruby_ast(scope.in_boolean_context))
        if scope.function_scope? or scope.component_scope?
          ast
        else
          Yugo::ERB::StatementTag.new(ast)
        end
      end

      def end_if(scope)
        ast = Yugo::Ruby::End.instance
        if scope.function_scope? or scope.component_scope?
          ast
        else
          Yugo::ERB::StatementTag.new(ast)
        end
      end

      def elseif_clause(elem, scope)
        ast = Yugo::Ruby::ElsifClause.new(elem.elements.first.expression.ruby_ast(scope.in_boolean_context))
        if scope.function_scope? or scope.component_scope?
          [ast, elem.elements[1].ruby_ast(scope)]
        else
          [Yugo::ERB::StatementTag.new(ast), elem.elements[1].ruby_ast(scope)]
        end
      end

      def else_clause(elem, scope)
        ast = Yugo::Ruby::Else.instance
        if scope.function_scope? or scope.component_scope?
          [ast, elem.elements[1].ruby_ast(scope)]
        else
          [Yugo::ERB::StatementTag.new(ast), elem.elements[1].ruby_ast(scope)]
        end
      end
    end
  end
end
