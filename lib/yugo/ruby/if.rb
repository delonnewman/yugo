module Yugo
  module Ruby
    class If < Syntax
      attr_reader :predicate, :consequent, :alternate

      Contract C::ArrayOf[Syntax] => If
      def self.from(clauses)
        clauses_ = clauses.reject { |clause| clause.is_a?(End) }

        unless clauses_.length.even?
          raise "There should be an even number of clause not including a Yugo::Ruby::End"
        end

        pair(clauses_).reduce(nil) do |if_exp, (clause, exp)|
          if clause.nil?
            if_exp
          elsif clause.is_a?(Else)
            new(if_exp.predicate, if_exp.consequent, exp)
          else
            new(clause.predicate, exp)
          end
        end
      end

      Contract Syntax, Syntax, C::Maybe[Syntax] => C::Any
      def initialize(predicate, consequent, alternate = nil)
        @predicate = predicate
        @consequent = consequent
        @alternate = alternate
      end

      def to_sexp
        s(:if, @predicate.to_sexp, @consequent.to_sexp, @alternate&.to_sexp)
      end

      private

      def self.pair(array)
        p array
        i = 0
        a = []
        while i <= array.length
          a.push([array[i], array[i + 1]])
          i += 2
        end
        a
      end
    end
  end
end
