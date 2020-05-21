require_relative '../../lib/game'

describe 'treasure-player interaction' do
  context 'empty + monster as level,' do
    let(:input) { StringIO.new("a") }
    it 'it will exit' do
      test = Interface.new
      allow(test).to receive(:level_data) { [["  ","t "]] }
      #allow_any_instance_of(Object).to receive(:exit) {}
      $stdin = input
      game = Game.new(test)
      game.start_game
      expect { game.main_loop }.to raise_exception(SystemExit)
      $stdin = STDIN
    end
    it "the exit value should 2; code for treasue - player" do
      test = Interface.new
      allow(test).to receive(:level_data) { [["  ","t "]] }
      $stdin = input
      game = Game.new(test)
      game.start_game
      begin
        game.main_loop
      rescue SystemExit=>exit_code
        expect(exit_code.status).to eq(2)
      end
      $stdin = STDIN
    end
  end
end
