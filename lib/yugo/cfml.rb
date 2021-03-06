require 'erb'
require 'treetop'

require_relative 'runtime'

require_relative 'erb'
require_relative 'ruby'
require_relative 'tags'

require_relative 'utils'
require_relative 'scope'
require_relative 'component'

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
require_relative 'cfml/this'
require_relative 'cfml/super'
require_relative 'cfml/boolean'
require_relative 'cfml/integer'
require_relative 'cfml/float'
require_relative 'cfml/string'
require_relative 'cfml/quote'
require_relative 'cfml/identifier'
require_relative 'cfml/property_access'
require_relative 'cfml/binary_operation'
require_relative 'cfml/prefix_operation'
require_relative 'cfml/function_macros'
require_relative 'cfml/function_application'
require_relative 'cfml/operators'
require_relative 'cfml/assignment'

require_relative 'cfml/set_tag'
require_relative 'cfml/output_tag'
require_relative 'cfml/if_tag'
require_relative 'cfml/script_tag'
require_relative 'cfml/include_tag'
require_relative 'cfml/param_tag'
require_relative 'cfml/function_tag'
require_relative 'cfml/component_tag'
require_relative 'cfml/query_tag'
require_relative 'cfml/switch_tag'
require_relative 'cfml/loop_tag'

require_relative 'cfml/parser'

module Yugo
  module CFML
    def logger
      @logger ||= Logger.new(STDERR)
    end

    TOPLEVEL = Scope.new

    def ruby_ast(node, scope = TOPLEVEL)
      if Yugo::Utils.plain_node?(node)
        Yugo::Utils.plain_node(node, scope)
      else
        node.ruby_ast(scope)
      end
    end

    def to_sexp(node)
      if node.respond_to?(:to_sexp)
        node.to_sexp
      else
        [:node, node.text_value]
      end
    end

    def ruby_ast_from_string(str, scope = TOPLEVEL)
      ruby_ast(parse(str), scope)
    end

    def compile(node, scope = TOPLEVEL)
      ruby_ast(node, scope).compile
    end

    def compile_string(str, scope = TOPLEVEL)
      compile(parse(str), scope)
    end

    def compile_file(file, scope = TOPLEVEL)
      compile(parse_file(file), scope)
    end

    def evaluate(node, env = binding, scope = TOPLEVEL)
      ::ERB.new(ruby_ast(node, scope).compile).result(env)
    end

    def evaluate_string(str, env = binding, scope = TOPLEVEL)
      evaluate(parse(str), env, scope)
    end

    def parse(str, source = 'string')
      logger.info "Parsing: #{str.inspect}"
      Parser.parse(str, source)
    end

    def parse_file(file)
      parse(IO.read(file), file)
    end

    extend self
  end
end
