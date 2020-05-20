require_relative '../../lib/tile.rb'

describe Key do
  describe '#string' do
    it 'should have " k " representation' do
      expect(subject.string).to eq(" k ")
    end
  end

  before do ### ideas for how to double this?
    allow_any_instance_of(Interface).to receive(:get_key) {}
    allow_any_instance_of(Interface).to receive(:remove_key_from_level) {true}
  end

  describe '#player_interaction' do
    it 'should call #get_key and #remove_key_from_level' do ### will need to be updated
      expect(subject.player_interaction).to eq(true)
    end
  end
end
