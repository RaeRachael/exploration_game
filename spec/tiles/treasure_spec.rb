require_relative '../../lib/tile.rb'

describe Treasure do
  describe '#string' do
    it 'should have " t " representation' do
      expect(subject.string).to eq(" t ")
    end
  end

  before do ### ideas for how to double this?
    allow_any_instance_of(Interface).to receive(:print_to_screen) {}
  end

  describe '#player_interaction' do
    it 'should print level then exit' do ### will need to be updated
      expect { subject.player_interaction }.to raise_error(SystemExit)
    end
  end
end
