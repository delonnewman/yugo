require_relative 'function_macros/list_functions'
require_relative 'function_macros/struct_functions'
require_relative 'function_macros/string_functions'
require_relative 'function_macros/runtime_functions'
require_relative 'function_macros/component_functions'

module Yugo
  module CFML
    module FunctionMacros
      include ListFunctions
      include StructFunctions
      include StringFunctions
      include RuntimeFunctions
      include ComponentFunctions

      def self.macros
        @macros ||= constants.flat_map do |const|
          mod = const_get(const)
          if mod.is_a?(Module)
            mod.instance_methods(false).map do |name|
              [name, mod.instance_method(name).bind(mod)]
            end
          else
            nil
          end
        end.reject(&:nil?).to_h
      end

      def self.macro(name)
        macros[name]
      end
    end
  end
end
