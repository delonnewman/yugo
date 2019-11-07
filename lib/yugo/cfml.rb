require 'treetop'

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
require_relative 'cfml/operators'
require_relative 'cfml/assignment'
require_relative 'cfml/parser'

module Yugo
  module CFML
    def compile(node)
      p node
    end

    def compile_string(str)
      compile(Parser.parse(str))
    end

    extend self
  end
end