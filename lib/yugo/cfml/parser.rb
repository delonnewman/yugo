module Yugo
  module CFML
    class Parser
      Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'cfml_parser.treetop')))
      @@parser = CFMLParser.new

      def self.parse(str, source = 'string')
        res = @@parser.parse(str)
        if res.nil?
          raise "#{@@parser.failure_reason} - #{source}#{@@parser.failure_line}:#{@@parser.failure_column}"
        else
          res
        end
      end
    end
  end
end
