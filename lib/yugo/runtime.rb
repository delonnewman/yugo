require_relative 'list'
require_relative 'struct'
require_relative 'cfml'

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

    def h(str)
      CGI.escape_html(str)
    end
  end
end
