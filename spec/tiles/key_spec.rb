require_relative '../../lib/tile.rb'

describe Key do
  let(:interface_double) { double(:interface) }
  let(:subject) { Key.new(interface_double) }
  describe '#string' do
    it 'should have " k " representation' do
      expect(subject.string).to eq(" k ")
    end
  end

  before do
    allow(interface_double).to receive(:collect_key) {}
    allow(interface_double).to receive(:remove_key_from_level) { true }
  end

  describe '#player_interaction' do
    it 'should call #collect_key and #remove_key_from_level' do # a good test?
      expect(subject.player_interaction).to eq(true)
    end
  end
end
