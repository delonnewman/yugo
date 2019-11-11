begin
  require 'spirit_hands'
  SpiritHands.colored_prompt = false
  SpiritHands.hirb = false
rescue LoadError => e
  raise unless e.message =~ /.*such file.*spirit_hands/
  puts 'no SpiritHands'  
end
