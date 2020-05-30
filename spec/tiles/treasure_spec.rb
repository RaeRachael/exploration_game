require_relative '../../lib/tile.rb'

describe Treasure do
  let(:interface_double) { double(:interface) }
  let(:subject) { Treasure.new(interface_double) }
  describe '#string' do
    it 'should have " t " representation' do
      expect(subject.string).to eq(" t ")
    end
  end

  before do ### ideas for how to double this?
    allow(interface_double).to receive(:print_to_screen) {}
  end

  describe '#player_interaction' do
    it 'should print level then exit' do ### will need to be updated
      expect { subject.player_interaction }.to raise_error(SystemExit)
    end
  end
end
