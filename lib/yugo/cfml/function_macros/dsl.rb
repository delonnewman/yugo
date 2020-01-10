module Yugo
  module CFML
    module FunctionMacros
      module DSL
        def self.macros
          @macros ||= {}
        end
  
        def self.macro(name, &blk)
          $stderr.puts "WARNING: A function macro named #{name} is already defined" if macros.key?(name)
          macros[name] = blk
        end
      end
    end
  end
end
