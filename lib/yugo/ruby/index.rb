module Yugo
  module Ruby
    class Index < Syntax
      attr_reader :object, :indexes

      Contract C::Maybe[Syntax], C::ArrayOf[Syntax] => C::Any
      def initialize(object, indexes = [])
        @object = object
        @indexes = indexes
      end

      def to_sexp
        s(:index, @object&.to_sexp, *@indexes.map(&:to_sexp))
      end
    end
  end
end
