require_relative '../../lib/game'

describe 'StairsUp: monster-player interaction' do
  context 'empty + monster as level,' do
    let(:input4) { StringIO.new("ad") }
    it 'it will exit' do
      test3 = Interface.new
      allow_any_instance_of(Monster).to receive(:possible_moves) {nil}
      allow(test3).to receive(:level_data) { [["  ","S "],["  ","DX"]] }
      $stdin = input4
      game = Game.new(test3)
      game.setup
      expect { game.main_loop }.to raise_exception(SystemExit)
      $stdin = STDIN
    end
    it "the exit value should 1; code for monster - player" do
      test3 = Interface.new
      allow_any_instance_of(Monster).to receive(:possible_moves) {nil}
      allow(test3).to receive(:level_data) { [["  ","S "],["  ","DX"]] }
      $stdin = input4
      game = Game.new(test3)
      game.setup
      begin
        game.main_loop
      rescue SystemExit=>exit_code
        expect(exit_code.status).to eq(1)
      end
      $stdin = STDIN
    end
  end
end
