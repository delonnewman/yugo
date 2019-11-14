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

    def isdefined(var)
      raise "Not implemented"
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

    # Struct Functions

    def structkeyexists(struct, key)
      struct.key?(key)
    end

    def structnew
      Yugo::Struct.new
    end

    def structappend(*args)
      raise 'Not Implemented'
    end

    # Component Functions

    def createobject(*args)
      raise 'Not Implemented'
    end

    # Tag Functions
    
    def getbasetaglist(*args)
      raise 'Not Implemented'
    end

    # String Functions
    
    def findnocase(*args)
      raise 'Not Implemented'
    end

    # Math functions

#    def pi
#      Math::PI
#    end
#
#    def sin(x)
#      Math.sin(x)
#    end
#
#    def cos(x)
#      Math.cos(x)
#    end
#
#    def acos(x)
#      Math.acos(x)
#    end
#
#    def asin(x)
#      Math.asin(x)
#    end
#
#    def ceiling(x)
#      x.ceiling
#    end
#
#    def abs(x)
#      x.abs
#    end
#
#    def floor(x)
#      x.floor
#    end
#    alias int floor
#
#    def round(x)
#      x.round
#    end
#
#    # bitwise functions
#    
#    def bitnot(x)
#      ~x
#    end
#
#    def bitand(a, b)
#      a & b
#    end
#
#    def bitor(a, b)
#      a | b
#    end
#
#    def bitxor(a, b)
#      a ^ b
#    end
  end
end
