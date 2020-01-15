module Yugo
  module Ruby
    class Syntax
      include Contracts::Core

      C = Contracts

      protected

      def compile
        Unparser.unparse(to_sexp)
      end

      def s(type, *children)
        Parser::AST::Node.new(type, children)
      end
    end
  end
end
