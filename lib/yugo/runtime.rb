require_relative 'list'
require_relative 'struct'
require_relative 'database'

module Yugo
  class TypeError < Exception; end

  module Runtime
    include Rack::Utils

    def dump(var, opts = {})
      if var.respond_to?(:yugo_dump)
        var.yugo_dump(opts)
      else
        var.inspect
      end
    end
    alias writedump dump

    def h(str)
      escape_html(str)
    end

    # Scopes

    def server
      @server
    end

    def cgi
      @cgi
    end

    def form
      @form
    end

    def url
      @url
    end

    def variables
      @variables
    end

    def session
      raise 'Not Implemented'
    end
  end
end
