module Yugo
  module Ruby
    class InterpolatedString < Syntax
      attr_reader :parts
      
      Contract C::ArrayOf[C::Or[::String, Syntax]] => C::Any
      def initialize(parts)
        @parts = parts
      end

      def parts_to_sexp
        parts.map do |part|
          if part.is_a?(Syntax)
            part.to_sexp
          else
            part
          end
        end
      end

      def to_sexp
        s(:dstr, *parts_to_sexp)
      end
    end
  end
end
