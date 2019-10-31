require_relative '../lib/yugo/lang'

RSpec.describe Yugo::Lang::Parser do
  context '.parse' do
    before :all do
      @examples = [
        '<!---->',
        '<!-- -->',
        '<!-- Hello -->',
        '<!-- <! - - 234q24q245q43tqwrsawf > - - -->',
        '<cfoutput>3 + 4 = #3 + 4#</cfoutput>',
      ]
    end

    it 'should return not nil for all of the valid examples' do
      @examples.each do |example|
        expect(Yugo::Lang::Parser.parse(example)).not_to be_nil
      end
    end
  end
end
