require_relative '../../lib/tile.rb'

describe Wall do
  describe '#string' do
    it 'should have "///" representation' do
      expect(subject.string).to eq("///")
    end
  end

  describe '#blocks_player' do
    it 'should block player' do
      expect(subject.blocks_player).to eq(true)
    end
  end
  describe '#blocks_monster'do
    it 'should block monster' do
      expect(subject.blocks_monster).to eq(true)
    end
  end
end
