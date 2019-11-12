require_relative 'list'
require_relative 'struct'
require_relative 'database'

module Yugo
  class TypeError < Exception; end

  module Runtime
    def dump(var, opts = {})
      if var.respond_to?(:yugo_dump)
        var.yugo_dump(opts)
      else
        var.inspect
      end
    end
    alias writedump dump

    def h(str)
      CGI.escape_html(str)
    end
  end
end
