require 'treetop'
require 'erb'

require_relative 'runtime'

require_relative 'ruby'
require_relative 'erb'
require_relative 'tags'

require_relative 'cfml/variable_scope'
require_relative 'cfml/node'
require_relative 'cfml/syntax'
require_relative 'cfml/content'
require_relative 'cfml/text'
require_relative 'cfml/comment'
require_relative 'cfml/attribute'
require_relative 'cfml/content'
require_relative 'cfml/statement'
require_relative 'cfml/expression'
require_relative 'cfml/null'
require_relative 'cfml/boolean'
require_relative 'cfml/integer'
require_relative 'cfml/float'
require_relative 'cfml/string'
require_relative 'cfml/quote'
require_relative 'cfml/identifier'
require_relative 'cfml/binary_operation'
require_relative 'cfml/unary_operation'
require_relative 'cfml/function_application'
require_relative 'cfml/operators'
require_relative 'cfml/assignment'

require_relative 'cfml/set_tag'
require_relative 'cfml/output_tag'
require_relative 'cfml/if_tag'
require_relative 'cfml/script_tag'

require_relative 'cfml/parser'

module Yugo
  module CFML
    def ruby_ast(node, scope = VariableScope.new)
      if node.respond_to?(:ruby_ast)
        node.ruby_ast(scope)
      else
        Yugo::ERB::Text.new(node.text_value)
      end
    end

    def ruby_ast_from_string(str, scope = VariableScope.new)
      ruby_ast(parse(str), scope)
    end

    def compile(node, scope = VariableScope.new)
      ruby_ast(node, scope).compile
    end

    def compile_string(str, scope = VariableScope.new)
      compile(parse(str), scope)
    end

    def evaluate(node, env = binding, scope = VariableScope.new)
      ::ERB.new(ruby_ast(node, scope).compile).result(env)
    end

    def evaluate_string(str, env = binding, scope = VariableScope.new)
      evaluate(parse(str), env, scope)
    end

    def parse(str)
      res = Parser.parse(str)
      raise "There was an error parsing the given string: #{str}" if res.nil?
      res
    end

    def parse_attribute_list(list)
      init = {}
      unless list.nil? or list.empty?
        list.elements[0].elements.reject { |elem| elem.text_value =~ /\A\s+\z/ }.reduce(init) do |h, attr|
          h.merge!(attr.identifier.ruby_ast => attr.expression.ruby_ast)
        end
      end
      init
    end

    def elements_empty?(node)
      node.elements.nil? or node.elements.empty?
    end

    def elements_present?(node)
      !elements_empty?(node)
    end

    def plain_node?(node)
      node.class == Treetop::Runtime::SyntaxNode
    end

    extend self
  end
end
