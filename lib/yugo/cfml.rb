require 'treetop'

require_relative 'ruby'
require_relative 'erb'

require_relative 'cfml/node'
require_relative 'cfml/syntax'
require_relative 'cfml/content'
require_relative 'cfml/text'
require_relative 'cfml/comment'
require_relative 'cfml/open_tag'
require_relative 'cfml/attribute'
require_relative 'cfml/content'
require_relative 'cfml/end_tag'
require_relative 'cfml/content_tag'
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
require_relative 'cfml/parser'

module Yugo
  module CFML
    def ruby_ast(node)
      p node
      if node.respond_to?(:ruby_ast)
        node.ruby_ast
      else
        Yugo::ERB::Text.new(node.text_value)
      end
    end

    def ruby_ast_from_string(str)
      ruby_ast(parse(str))
    end

    def compile(node)
      ruby_ast(node).compile
    end

    def compile_string(str)
      compile(parse(str))
    end

    def parse(str)
      Parser.parse(str)
    end

    extend self
  end
end