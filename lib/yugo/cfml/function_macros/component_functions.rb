module Yugo
  module CFML
    module FunctionMacros
      module ComponentFunctions
        OBJECT_TYPES = %w{component java}

        def createobject(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          raise "Wrong number of arguments expected 2, got: #{args.length}" if args.length != 2
          case args[0]
          when Yugo::Ruby::String
            case args[0].value
            when 'component'
              args[1].as_constant
            when 'java'
              Yugo::Utils.java_class(args[1].value)
            else
              raise "Don't know how to create an object of this type: #{args[0].value.inspect}"
            end
          else
            raise "Object type should be one of the following strings: #{OBJECT_TYPES.join(', ')}"
          end
        end

        def init(node, scope)
          args = Yugo::Utils.function_arguments(node, scope)
          Yugo::Ruby::FunctionApplication.new(Yugo::Ruby::Identifier.from(:new), args)
        end
      end
    end
  end
end
