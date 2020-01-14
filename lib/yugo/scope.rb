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

    def function_scope?
      if @context == :function
        true
      elsif @parent
        @parent.function_scope?
      else
        false
      end
    end

    def new_scope(context = nil)
      self.class.new(self, context)
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
