require_relative '../../lib/tile.rb'

describe Key do
  let(:interface_double) {double(:interface)}
  let(:subject) {Key.new(interface_double)}
  describe '#string' do
    it 'should have " k " representation' do
      expect(subject.string).to eq(" k ")
    end
  end

  before do ### ideas for how to double this?
    allow(interface_double).to receive(:get_key) {}
    allow(interface_double).to receive(:remove_key_from_level) {true}
  end

  describe '#player_interaction' do
    it 'should call #get_key and #remove_key_from_level' do ### will need to be updated
      expect(subject.player_interaction).to eq(true)
    end
  end
end
