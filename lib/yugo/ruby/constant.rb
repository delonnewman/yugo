module Yugo
  module Ruby
    class Constant < Syntax

      Contract C::RespondTo[:to_s] => Constant
      def self.from(value)
        value.to_s.split('::').reduce(nil) do |const, part|
          new(const, Identifier.from(part))
        end
      end

      Contract C::Maybe[C::Or[Identifier, Constant]], Identifier => C::Any
      def initialize(scope, identifier)
        @scope = scope
        @identifier = identifier
      end

      def to_sexp
        s(:const, @scope&.to_sexp, @identifier.to_sexp)
      end
    end
  end
end
