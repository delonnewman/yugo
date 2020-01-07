module Yugo
  module CFML
    module FunctionMacros
      def self.macros
        @macros ||= {}
      end

      def self.macro(name, &blk)
        $stderr.puts "WARNING: A function macro named #{name} is already defined" if macros.key?(name)
        macros[name] = blk
      end

      macro :getbasetemplatepath do
        Yugo::Ruby::Macro.new(Yugo::Ruby::Identifier.new(:template_path))
      end

      macro :lastlist do |node, scope|
        args = Yugo::CFML.function_arguments(node, scope)
        Yugo::Ruby::MethodResolution.new(
          Yugo::Ruby::MethodResolution.new(
            args[0],
            Yugo::Ruby::MethodCall.new(
              Yugo::Ruby::Identifier.new(:split), [args[1] || Yugo::Ruby::String.new(',')])
          ),
          Yugo::Ruby::Identifier.new(:last)
        )
      end

      macro :structnew do |node, scope|
        args = Yugo::CFML.function_arguments(node, scope)
        Yugo::Ruby::MethodResolution.new(
          Yugo::Ruby::Identifier.new(:'Yugo::Struct'),
          Yugo::Ruby::MethodCall.new(Yugo::Ruby::Identifier.new(:new), args)
        )
      end

      macro :structappend do |node, scope|
        args      = Yugo::CFML.function_arguments(node, scope)
        overwrite = args[2].nil? ? true : args[2].as_boolean.is_a?(Yugo::Ruby::True)
        method    = overwrite ? :merge! : :merge
        Yugo::Ruby::MethodResolution.new(
          args[0],
          Yugo::Ruby::MethodCall.new(
            Yugo::Ruby::Identifier.new(method), [args[1]])
        )
      end

      macro :structclear do |node, scope|
        args = Yugo::CFML.function_arguments(node, scope)
        Yugo::Ruby::MethodResolution.new(
          args[0],
          Yugo::Ruby::MethodCall.new(
            Yugo::Ruby::Identifier.new(:clear)))
      end

      macro :findnocase do |node, scope|
        args = Yugo::CFML.function_arguments(node, scope)
        substr = Yugo::Ruby::MethodResolution.new(args[0], Yugo::Ruby::Identifier.new(:downcase))
        args_ = if args.length == 3
                  [substr, args[2]]
                else
                  [substr]
                end

        ast = Yugo::Ruby::MethodResolution.new(
          Yugo::Ruby::MethodResolution.new(args[1], Yugo::Ruby::Identifier.new(:downcase)),
          Yugo::Ruby::MethodCall.new(Yugo::Ruby::Identifier.new(:index), args_))

        if scope.context != :boolean
          Yugo::Ruby::BinaryOperation.new(
            Yugo::Ruby::Operator.new(:'||'), ast, Yugo::Ruby::Integer.new(0))
        else
          ast
        end
      end

      macro :find do |node, scope|
        args = Yugo::CFML.function_arguments(node, scope)
        args_ = if args.length == 3
                  [args[0], args[2]]
                else
                  [args[0]]
                end

        ast = Yugo::Ruby::MethodResolution.new(
          args[1],
          Yugo::Ruby::MethodCall.new(
            Yugo::Ruby::Identifier.new(:index), args_)
        )

        if scope.context != :boolean
          Yugo::Ruby::BinaryOperation.new(
            Yugo::Ruby::Operator.new(:'||'),
            ast,
            Yugo::Ruby::Integer.new(0)
          )
        else
          ast
        end
      end

      macro :listfind do |node, scope|
        args = Yugo::CFML.function_arguments(node, scope)
        ast = Yugo::Ruby::MethodResolution.new(
          Yugo::Ruby::MethodResolution.new(
            args[0],
            Yugo::Ruby::MethodCall.new(
              Yugo::Ruby::Identifier.new(:split), [args[2] || Yugo::Ruby::String.new(',')])
          ),
          Yugo::Ruby::Identifier.new(:index),
          [args[1]]
        )

        if scope.context != :boolean
          Yugo::Ruby::BinaryOperation.new(
            Yugo::Ruby::Operator.new(:'||'),
            ast,
            Yugo::Ruby::Integer.new(0)
          )
        else
          ast
        end
      end

      # TODO: translate arguments to defined?
      macro :isdefined do |node, scope|
        args = Yugo::CFML.function_arguments(node, scope)
        Yugo::Ruby::MethodCall.new(
          Yugo::Ruby::Identifier.new(:defined?), args)
      end
    end
  end
end
