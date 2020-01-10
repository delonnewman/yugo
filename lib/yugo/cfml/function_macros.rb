require_relative 'function_macros/list_functions'
require_relative 'function_macros/struct_functions'
require_relative 'function_macros/string_functions'
require_relative 'function_macros/runtime_functions'

module Yugo
  module CFML
    module FunctionMacros
      include ListFunctions
      include StructFunctions
      include StringFunctions
      include RuntimeFunctions

      def self.macros
        @macros ||= constants.flat_map do |const|
          mod = const_get(const)
          mod.instance_methods(false).map do |name|
            [name, mod.instance_method(name).bind(mod)]
          end
        end.to_h
      end

      def self.macro(name)
        macros[name]
      end
    end
  end
end
