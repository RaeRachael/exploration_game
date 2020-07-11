require_relative '../../lib/game'

describe "monsters can't stack up" do
  context 'monster movement' do
    it "monsters should block each other" do
      test = Interface.new
      allow(test).to receive(:level_data_1) { [["  -X", "  -X"]] }
      game = Game.new(test)
      game.setup
      expect(test.blocked?(3, 5, "monster")).to eq(true)
    end
    it "monsters_block correctly returns false" do
      test = Interface.new
      allow(test).to receive(:level_data_1) { [["  -X", "  -X"]] }
      game = Game.new(test)
      game.setup
      expect(test.blocked?(3, 3, "monster")).to eq(false)
    end
  end
end
