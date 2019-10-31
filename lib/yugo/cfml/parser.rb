module Yugo
  module CFML
    class Parser
      Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'cfml_parser.treetop')))
      @@parser = CFMLParser.new

      def self.parse(str)
        @@parser.parse(str)
      end
    end
  end
end
