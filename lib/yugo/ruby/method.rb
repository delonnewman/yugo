module Yugo
  module Ruby
    class Method < Syntax
      attr_reader :name, :arguments, :body

      Contract Identifier, C::ArrayOf[Ruby::Syntax], C::Or[Ruby::Program, ERB::Content] => C::Any
      def initialize(name, arguments, body)
        @name = name
        @arguments = arguments
        @body = body
      end

      def to_sexp
        name = @name.symbol
        args = s(:args, *@arguments.map { |arg| s(:arg, arg.to_sexp) })
        if @body.empty?
          s(:def, name, args, nil)
        else
          s(:def, name, args, *@body.map(&:to_sexp))
        end
      end
    end
  end
end
