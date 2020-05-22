require_relative '../../lib/game'

describe 'monster-player interaction' do
  context 'empty + monster as level,' do
    let(:input) { StringIO.new("a") }
    it 'it will exit' do
      test = Interface.new
      allow(test).to receive(:level_data) { [["  ","X "]] }
      #allow_any_instance_of(Object).to receive(:exit) {}
      $stdin = input
      game = Game.new(test)
      game.start_game
      expect { game.main_loop }.to raise_exception(SystemExit)
      $stdin = STDIN
    end
    it "the exit value should 1; code for monster - player" do
      test = Interface.new
      allow(test).to receive(:level_data) { [["  ","X "]] }
      $stdin = input
      game = Game.new(test)
      game.start_game
      begin
        game.main_loop
      rescue SystemExit=>exit_code
        expect(exit_code.status).to eq(1)
      end
      $stdin = STDIN
    end
  end
end