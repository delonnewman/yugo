module Yugo
  module Ruby
    class Syntax
      include Contracts::Core

      C = Contracts

      Contract C::None => ::String
      def compile
        Unparser.unparse(to_sexp)
      end

      protected

      Contract ::Symbol, C::Args[C::Any] => Parser::AST::Node
      def s(type, *children)
        Parser::AST::Node.new(type, children)
      end

      Contract ::String => ::String
      def compile_template(template)
        ::ERB.new(template.lines.map { |x| x.sub(/^\s+/, '') }.join('')).result(binding)
      end
    end
  end
end
