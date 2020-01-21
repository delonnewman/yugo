module Yugo
  class Scope
    attr_reader :context, :variables

    def initialize(parent = nil, context = nil)
      @parent    = parent
      @variables = {}
      @context   = context
    end

    def top_level?
      @parent.nil?
    end

    def in_scope_of?(context)
      @contexts ||= {}
      @contexts[context] ||=
        if @context == context
          true
        elsif @parent
          @parent.in_scope_of?(context)
        else
          false
        end
    end

    def erb_context?
      !function_scope? and !component_scope?
    end

    def query_scope?
      in_scope_of?(:query)
    end

    def function_scope?
      in_scope_of?(:function)
    end

    def component_scope?
      in_scope_of?(:component)
    end

    def boolean_context?
      in_scope_of?(:boolean)
    end

    def numeric_context?
      in_scope_of?(:numeric)
    end

    def new_scope(context = nil)
      self.class.new(self, context)
    end

    def in_function_scope
      new_scope(:function)
    end

    def in_component_scope
      new_scope(:component)
    end

    def in_query_scope
      new_scope(:query)
    end

    def in_boolean_context
      new_scope(:boolean)
    end

    def in_numeric_context
      new_scope(:numeric)
    end

    def variable_exists?(name)
      if @variables.key?(name)
        true
      elsif @parent
        @parent.variable_exists?(name)
      else
        false
      end
    end

    def lookup(name)
      if @variables.key?(name)
        self
      elsif @parent
        @parent.lookup(name)
      else
        nil
      end
    end

    def add_variable(name, syntax)
      @variables[name] = syntax
    end
  end
end
