module Yugo
  module Java
    module Utils
      def java_class(class_name)
        Yugo::Ruby::Identifier.from(class_name)
      end

      def init_java_class(class_name, arguments = [])
        klass = java_class(class_name)
        if arguments.empty?
          Yugo::Ruby::MethodResolution.new(klass, Yugo::Ruby::Identifier.from(:new))
        else
          Yugo::Ruby::MethodResolution.new(klass, Yugo::Ruby::MethodCall.new(Yugo::Ruby::Identifier.from(:new), arguments))
        end
      end

      module_function :java_class, :init_java_class
    end
  end
end
