require_relative '../../lib/tile.rb'

describe Empty do
  describe '#string' do
    it 'should have "   " representation' do
      expect(subject.string).to eq("   ")
    end
  end
end
