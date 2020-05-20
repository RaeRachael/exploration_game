require_relative '../../lib/tile.rb'

describe StairsDown do
  describe '#string' do
    it 'should have " D " representation' do
      expect(subject.string).to eq(" D ")
    end
  end

  context 'setting level_load being call to true value' do
    before do ### ideas for how to double this?
      allow_any_instance_of(Interface).to receive(:level_load) {true}
      allow_any_instance_of(Interface).to receive(:lvl_down) {}
      allow_any_instance_of(Interface).to receive(:print_to_screen) {}
    end

    describe '#player_interaction' do
      it 'should do nothing unless moved onto' do
        expect(subject.player_interaction).to eq(nil)
      end
      it 'should load_level otherwise' do ### WEAK TEST
        subject.blocks_player
        expect(subject.player_interaction).to eq(true)
      end
    end
  end
end
