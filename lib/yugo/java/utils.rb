module Yugo
  module Java
    module Utils
      def java_class(class_name)
        parts = class_name.split('.').map do |part|
          if part.downcase == part
            part.capitalize
          else
            part
          end
        end
        Yugo::Ruby::Identifier.from(parts.join('::').to_sym)
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
