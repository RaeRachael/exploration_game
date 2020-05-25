require_relative '../../lib/tile.rb'

describe StairsDown do
  let(:interface_double) {double(:interface)}
  let(:subject) {StairsDown.new(interface_double)}
  describe '#string' do
    it 'should have " D " representation' do
      expect(subject.string).to eq(" D ")
    end
  end

  context 'setting level_load being call to true value' do

    describe '#player_interaction' do
      it 'should do nothing unless moved onto' do
        expect(subject.player_interaction).to eq(nil)
      end
      it 'should load_level otherwise' do ### WEAK TEST
        subject.blocks_player?
        expect{ subject.player_interaction }
        .to raise_error(LevelChange)
        begin
          subject.blocks_player?
          subject.player_interaction
        rescue LevelChange => code
          expect(code.message).to eq('down')
        end
      end
    end
  end
end
