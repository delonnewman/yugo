module Yugo
  module Ruby
    class MethodResolution < Syntax
      attr_reader :object, :method_name, :arguments

      def initialize(object, method_name, arguments = nil)
        @object = object
        @method_name = method_name
        @arguments = arguments
      end

      def compile
        if arguments
          "#{object.compile}.#{method_name.compile}(#{arguments.map(&:compile).join(', ')})"
        else
          "#{object.compile}.#{method_name.compile}"
        end
      end

      def to_sexp
        [:method_resolution, @object.to_sexp, @method_name.to_sexp, @arguments.map(&:to_sexp)]
      end
    end
  end
end
