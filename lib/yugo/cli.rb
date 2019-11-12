require 'yugo'
require 'pp'

module Yugo
  class CLI < Thor
    desc "parse FILE", "Parse CFML code into an AST and print out the result"
    def parse(file)
      pp CFML.parse_file(file).to_sexp
    end

    desc "compile FILE", "Compile CFML code into Ruby / ERB code and print out the result"
    def compile(file)
      puts CFML.compile_file(file)
    end
  end
end
