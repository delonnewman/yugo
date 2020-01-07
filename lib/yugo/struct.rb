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

    def [](key)
      super(key.to_sym)
    end

    def []=(key, value)
      super(key.to_sym, value)
    end

    def clear
      keys.each do |key|
        delete(key)
      end
      true
    end

    def yugo_dump(opts = {})
      label = opts.fetch(:label, 'struct')

      struct = self
      tag.table.table do
        caption(style: 'caption-side:top') { label } <<
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
