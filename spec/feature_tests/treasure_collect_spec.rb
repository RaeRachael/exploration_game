require_relative '../../lib/game'

describe 'treasure-player interaction' do
  context 'empty + treasue as level,' do
    let(:input) { StringIO.new("a") }
    it 'it will exit' do
      test = Interface.new
      allow(test).to receive(:level_data) { [["  ","t "]] }
      $stdin = input
      game = Game.new(test)
      game.setup
      expect { game.main_loop }.to raise_exception(SystemExit)
      $stdin = STDIN
    end
    it "the exit value should 2; code for treasue - player" do
      test = Interface.new
      allow(test).to receive(:level_data) { [["  ","t "]] }
      $stdin = input
      game = Game.new(test)
      game.setup
      begin
        game.main_loop
      rescue SystemExit=>exit_code
        expect(exit_code.status).to eq(2)
      end
      $stdin = STDIN
    end
  end
end
