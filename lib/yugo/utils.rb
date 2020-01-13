module Yugo
  module Utils
    def java_class(class_name)
      if class_name.start_with?('java.')
        Yugo::Ruby::Identifier.from(class_name)
      else
        parts = class_name.split('.')
        name = parts.last
        const = "Java::#{parts.slice(0, parts.length - 1).map { |x| x.capitalize }.join('')}::#{name}"
        Yugo::Ruby::Identifier.from(const)
      end
    end

    def attribute_list(list, scope)
      init = {}
      unless list.nil? or list.empty?
        list.elements.each do |elem|
          elem.elements.reject { |elem| elem.text_value =~ /\A\s+\z/ }.reduce(init) do |h, attr|
            h.merge!(attr.identifier.to_sym => attr.expression.ruby_ast(scope))
          end
        end
      end
      init
    end

    # TODO: add key/value arguments
    def function_arguments(node, scope)
      args = node.function_arguments
      if args.respond_to?(:argument_list)
        args.argument_list.elements.flat_map do |elem|
          if elem.respond_to?(:ruby_ast)
            elem.ruby_ast(scope)
          elsif !elem.elements.nil? and !elem.elements.empty?
            elem.elements.map { |e| p e; e.expression.ruby_ast(scope) }
          else
            []
          end
        end
      elsif args.respond_to?(:attribute_list)
        members = args.attribute_list.elements.map do |elem|
          [elem.elements[1].identifier.as_symbol, elem.elements[1].expression.ruby_ast(scope)]
        end
        [Yugo::Ruby::HashLiteral.new(members, include_braces: false, symbol_keys: true)]
      else
        raise "Don't know how to process these function arguments: #{node.inspect}"
      end
    end

    def elements_empty?(node)
      node.elements.nil? or node.elements.empty?
    end

    def elements_present?(node)
      !elements_empty?(node)
    end

    def plain_node?(node)
      node.class == Treetop::Runtime::SyntaxNode
    end

    module_function :java_class, :attribute_list, :function_arguments,
                    :elements_empty?, :elements_present?, :plain_node?
  end
end
