require_relative '../../lib/tile.rb'

describe DoorUnLocked do
  describe '#string' do
    it 'should have " | " representation' do
      expect(subject.string).to eq(" | ")
    end
  end

  describe '#blocks_monster' do
    it 'should be true' do
      expect(subject.blocks_monster).to eq(true)
    end
  end

  describe '#blocks_player' do
    it 'should be false' do
      expect(subject.blocks_player).to eq(false)
    end
  end
end
