require_relative '../lib/yugo'
require_relative 'generators'

G = Generators

RSpec.describe Yugo::CFML::Parser do
  include Gen::Test

  context '.parse' do
    it 'should parse comments' do
      for_all(G::Comment) do |comment|
        expect(Yugo::CFML::Parser.parse(comment)).not_to be_nil
      end
    end

    it 'should parse arithmetical operations' do
      for_all(G::ArithmeticalExpression) do |exp|
        tree = Yugo::CFML::Parser.parse("<cfset x = #{exp}>")
        puts "Expression: #{exp}"
        puts "Tree: #{tree.inspect}"
        expect(tree).not_to be_nil
      end
    end
  end
end
