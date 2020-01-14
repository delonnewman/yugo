module Yugo
  module CFML
    class ArgumentTag < Node; end

    class ReturnTag < Node
      def ruby_ast(scope)
        Yugo::Ruby::Macro.new(Yugo::Ruby::Identifier.from(:return), [expression.ruby_ast(scope)])
      end
    end

    class FunctionContent < Node
      def ruby_ast(scope)
        elem = elements[1]
        case elem
        when ArugmentTag
          Yugo::Ruby::NoOp.instance
        else
          elem.ruby_ast(scope)
        end
      end
    end

    class FunctionTag < Node
      def ruby_ast(scope)
        scope_ = scope.new_scope(:function)
        attrs = Yugo::Utils.attribute_list(open_function_tag.attribute_list, scope_)
        name = attrs.fetch(:name)

        args = arguments(scope_)
        args.each do |arg|
          scope_.add_variable(arg.fetch(:name).as_symbol, true)
        end
        arg_list = argument_list(args)

        ast = Yugo::Ruby::Method.new(name.as_identifier, arg_list, body(scope_))
        scope.add_variable(name.as_symbol, ast)
        if scope.erb_context?
          Yugo::ERB::StatementTag.new(ast)
        else
          ast
        end
      end

      def arguments(scope)
        function_body.content
          .select { |elem| elem.is_a?(ArgumentTag) }
          .map { |arg_tag| Yugo::Utils.attribute_list(arg_tag.attribute_list, scope) }
      end

      def argument_list(args)
        args.map do |arg|
          ident = arg.fetch(:name).as_identifier
          required = arg.fetch(:required, Yugo::Ruby::String.new('false')).as_ruby_boolean
          if required
            ident
          else
            Yugo::Ruby::Assignment.new(ident, Yugo::Ruby::Nil.instance)
          end
        end
      end

      def body(scope)
        exprs = function_body.content
          .reject { |elem| elem.is_a?(ArgumentTag) }
          .map { |elem| Yugo::CFML.ruby_ast(elem, scope) }
          .reject(&:nil?)
        Yugo::Ruby::Program.new(exprs)
      end
    end
  end
end
