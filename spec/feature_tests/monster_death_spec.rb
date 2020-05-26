require_relative '../../lib/game'

describe 'monster-player interaction' do
  context 'empty + monster as level,' do
    let(:input) { StringIO.new("a") }
    it "the exit value should 1; code for monster - player" do
      test = Interface.new
      allow(test).to receive(:level_data) { [["  ","X "]] }
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
