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

    def isdefined(var)
      raise "Not implemented"
    end

    # Math functions

    def pi
      Math::PI
    end

    def sin(x)
      Math.sin(x)
    end

    def cos(x)
      Math.cos(x)
    end

    def acos(x)
      Math.acos(x)
    end

    def asin(x)
      Math.asin(x)
    end

    def ceiling(x)
      x.ceiling
    end

    def abs(x)
      x.abs
    end

    def floor(x)
      x.floor
    end
    alias int floor

    def round(x)
      x.round
    end

    # bitwise functions
    
    def bitnot(x)
      ~x
    end

    def bitand(a, b)
      a & b
    end

    def bitor(a, b)
      a | b
    end

    def bitxor(a, b)
      a ^ b
    end
  end
end
