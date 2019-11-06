module Yugo
  class Struct < Hash
    include El

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

    def dump
      struct = self
      tag.table.table do
        caption(style: 'caption-side:top') { "struct" } <<
        tbody do
          if struct.empty?
            tr td("empty")
          else
            struct.map do |key, value|
              tr do
                th(key) << td(value)
              end
            end
          end
        end
      end
    end
  end
end
