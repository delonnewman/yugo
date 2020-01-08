require 'gen/test'
require 'contracts'
require 'contracts/gen'

C = Contracts

module Generators
  Comment = Gen::Generator.new do
    "<!--#{String.generate}-->"
  end

  Number = Gen::Generator.new do
    if C::Bool.generate
      Integer.generate
    else
      Float.generate
    end
  end

  MaybeSpace = Gen::Generator.new do
    n = (0..20).to_a.sample
    " " * n
  end

  Space = Gen::Generator.new do
    n = (1..20).to_a.sample
    " " * n
  end

  ArithmeticalExpression = Gen::Generator.new do
    op = %w{+ - * / % mod Mod MOd MOD mOD moD exp Exp EXp EXP eXP exP}.sample
    space = if op.downcase == 'mod' or op.downcase == 'exp'
              Space
            else
              MaybeSpace
            end
    "#{MaybeSpace.generate}#{Number.generate}#{space.generate}#{op}#{space.generate}#{Number.generate}#{MaybeSpace.generate}"
  end
end
