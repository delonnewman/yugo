module Yugo
  module Components
    class Object
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
    end
  end
end
