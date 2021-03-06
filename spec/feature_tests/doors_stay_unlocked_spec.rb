require_relative '../../lib/game'

describe 'doors stay unlocked: monster-player interaction' do
  context 'key and door, monster end' do
    let(:input) { StringIO.new("wsdaadadddw") }
    it "the exit value should 1; code for monster - player" do
      test = Interface.new
      allow_any_instance_of(Monster).to receive(:possible_moves) { nil }
      allow(test).to receive(:level_data_1) { [["-k-X", "S | "], ["    ", "D   "]] }
      $stdin = input
      game = Game.new(test)
      game.setup
      begin
        game.main_loop
      rescue SystemExit => exit_code
        expect(exit_code.status).to eq(1)
      end
      $stdin = STDIN
    end
  end
end
