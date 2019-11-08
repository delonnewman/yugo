module Yugo
  module CFML
    class Boolean < Node
      def ruby_ast(_scope)
        case text_value.downcase
        when 'true'
          Yugo::Ruby::True.new
        when 'false'
          Yugo::Ruby::False.new
        else
          raise "#{text_value.inspect} is not a valid boolean value"
        end
      end
    end
  end
end
