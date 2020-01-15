module Yugo
  class Component < Yugo::Struct
    def self.displayname(name = nil)
      if name
        @displayname = name
      else
        @displayname
      end
    end

    def self.hint(hint = nil)
      if hint
        @hint = hint
      else
        @hint
      end
    end

    def initialize(*args)
      super()
      init(*args)
    end
  end
end
