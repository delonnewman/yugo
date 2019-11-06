require_relative 'list'
require_relative 'struct'

module Yugo
  class TypeError < Exception; end

  module Runtime
    def dump(value)
      if value.respond_to?(:dump)
        value.dump
      else
        value.inspect
      end
    end
  end
end
