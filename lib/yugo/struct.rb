module Yugo
  class Struct < Hash
    def method_missing(method, value = nil)
      meth = method.to_s
      if meth.end_with?('=')
        name = meth.chop.to_sym
        self[name] = value
      else
        raise ArgumentError, "#{method} expected 0 arguments got 1" unless value.nil?
        self[method]
      end
    end
  end
end
