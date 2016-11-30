require 'spec_helper'

describe MercuryWebParser do
  after do
    MercuryWebParser.reset!
  end

  describe '#new' do
    it 'is a MercuryWebParser::Client' do
      expect(MercuryWebParser.new).to be_a_kind_of(MercuryWebParser::Client)
    end
  end
end
