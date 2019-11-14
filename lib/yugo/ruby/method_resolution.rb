module Yugo
  module Ruby
    class MethodResolution < Syntax
      attr_reader :object, :method_name, :arguments

      Contract Syntax, Identifier, C::ArrayOf[Syntax] => C::Any
      def initialize(object, method_name, arguments = [])
        @object = object
        @method_name = method_name
        @arguments = arguments
      end

      def compile
        if arguments.empty?
          "#{object.compile}.#{method_name.compile}"
        else
          "#{object.compile}.#{method_name.compile}(#{arguments.map(&:compile).join(', ')})"
        end
      end

      def to_sexp
        [:method_resolution, @object.to_sexp, @method_name.to_sexp, @arguments.map(&:to_sexp)]
      end
    end
  end
end
