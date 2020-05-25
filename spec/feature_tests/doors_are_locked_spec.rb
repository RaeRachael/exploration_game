require_relative '../../lib/game'

describe 'StairsDown: monster-player interaction' do
  context 'empty + monster as level,' do
    let(:input) { StringIO.new("dddw") }
    it 'it will exit' do
      test = Interface.new
      allow_any_instance_of(Monster).to receive(:possible_moves) {nil}
      allow(test).to receive(:level_data) { [[" X  ","  |t"]] }
      $stdin = input
      game = Game.new(test)
      game.setup
      expect { game.main_loop }.to raise_exception(SystemExit)
      $stdin = STDIN
    end
    it "the exit value should 1; code for monster - player" do
      test = Interface.new
      allow_any_instance_of(Monster).to receive(:possible_moves) {nil}
      allow(test).to receive(:level_data) { [[" X  ","  |t"]] }
      $stdin = input
      game = Game.new(test)
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
