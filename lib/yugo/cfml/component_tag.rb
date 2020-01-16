module Yugo
  module CFML
    class ComponentTag < Node
      def ruby_ast(scope)
        scope_ = scope.in_component_scope
        attrs = Yugo::Utils.attribute_list(open_component_tag.attribute_list, scope_)
        name = attrs.fetch(:displayname)
        parent = attrs[:extends]
        doc = attrs[:hint]

        init = init_code(scope_)
        ast = if init.empty? && parent.nil?
                Yugo::Ruby::Module.new(name.as_constant, body(nil, scope_))
              else
                Yugo::Ruby::Class.new(name.as_constant, body(init, scope_), parent.as_constant)
              end

        scope.add_variable(name.as_symbol, ast)

#        ast = if doc.nil?
#          ast
#        else
#          Yugo::Ruby::Program.new([
#            Yugo::Ruby::Comment.new(doc.value), ast])
#        end

        if scope.erb_context?
          Yugo::ERB::StatementTag.new(ast)
        else
          ast
        end
      end

      def methods(scope)
        component_body.content
          .select { |elem| elem.is_a?(FunctionTag) }
          .map { |f| f.ruby_ast(scope) }
      end

      def body(init_code, scope)
        exprs = if init_code
                  [initialize_method(init_code, scope)] + methods(scope)
                else
                  methods(scope)
                end
        Yugo::Ruby::Program.new(exprs)
      end

      def init_code(scope)
        component_body.content
            .reject { |elem| elem.is_a?(FunctionTag) }
            .map { |node| Yugo::CFML.ruby_ast(node, scope) }
            .reject(&:nil?)
      end

      def initialize_method(init_code, scope)
        Yugo::Ruby::Method.new(
          Yugo::Ruby::Identifier.new(:initialize), [], Yugo::Ruby::Program.new(init_code))
      end
    end
  end
end
