require_relative '../../lib/tile.rb'

describe Door do
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

  context 'player has no keys' do
    before do ### ideas for how to double this?
      allow_any_instance_of(Interface).to receive(:player_keys) {0}
    end

    describe '#blocks_player' do
      it 'should be true' do ### will need to be updated
        expect(subject.blocks_player).to eq(true)
      end
    end
  end

  context 'player has keys' do
    before do ### ideas for how to double this?
      allow_any_instance_of(Interface).to receive(:player_keys) {1}
      allow_any_instance_of(Interface).to receive(:use_key) {}
    end

    describe '#blocks_player' do
      it 'should be false' do ### will need to be updated
        expect(subject.blocks_player).to eq(false)
      end
    end
  end

  describe '#player_interaction' do
    it 'should turn into an unlocked door' do
      allow_any_instance_of(Interface).to receive(:turn_into_UnLocked) {true}
      expect(subject.player_interaction).to eq(true)
    end
  end
end
