module Yugo
  module Ruby
    class Syntax
      def compile(template)
        ::ERB.new(template.lines.map { |x| x.chomp.sub(/^\s+/, '') }.join('')).result(binding)
      end
    end
  end
end
