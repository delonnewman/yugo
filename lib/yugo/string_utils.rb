module Yugo
  module StringUtils
    def titlecase(string)
      string.split(/\s+/).map(&:capitalize).join(' ')
    end
  end
end
