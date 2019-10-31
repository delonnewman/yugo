module Yugo
  class List
    include Enumerable
    extend Forwardable

    def_delegator :@elements, :length

    attr_reader :elements

    alias to_a elements
    alias to_array elements

    def self.from_string(string, delimiters = ',')
      delim = if delimiters.length <= 1
                delimiters
              else
                Regexp.new(delimiters.split('').join('|'))
              end
      new(string.split(delim))
    end

    def self.convert(value)
      case value
      when List
        value
      when String
        from_string(value)
      else
        raise Yugo::TypeError, "Don't know how to convert #{value.inspect}:#{value.class} to a list"
      end
    end

    def initialize(elements)
      @elements = elements
    end

    def each
      @elements.each(&Proc.new)
    end

    def contains?(element)
      @elements.include?(element)
    end
  end
end
