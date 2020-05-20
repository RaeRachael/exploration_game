require_relative '../lib/tile.rb'

describe Tile do
  describe '#initialize' do
    it 'should blocks_player, blocks_monster and
    string as attr_reader' do
      expect(subject).to respond_to(:blocks_player).with(0).arguments
      expect(subject).to respond_to(:blocks_monster).with(0).arguments
      expect(subject).to respond_to(:string).with(0).arguments
    end
  end

end
