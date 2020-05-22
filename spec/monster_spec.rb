require_relative '../lib/moveable.rb'

describe Monster do
  subject(:monster) { described_class.new(1,1) }

  describe "should inherit properties from Moveable" do

    it "should require two arguments that define its location" do
      expect(Monster).to respond_to(:new).with(2).arguments
    end

    it "should have location parameters accessable" do
      expect(monster.x).to eq(1)
      expect(monster.y).to eq(1)
      monster.x, monster.y = 2,2
      expect(monster.x).to eq(2)
      expect(monster.y).to eq(2)
    end

    ## made private
      #it "should have a way to interface with other
      #classes using an instance of Interface" do
      #  expect(moveable.interface).to be_an_instance_of(Interface)
      #end
  end

  describe "#move" do
    context "move not blocked" do
      before do
        allow_any_instance_of(Interface).to receive(:blocked?) {false}
      end

      it "all possible moves result in the monster in the correct movement" do
        allow(subject).to receive(:possible_moves).and_return("w")
        expect{ monster.move }.to change{ monster.y }.by(-1)
        allow(subject).to receive(:possible_moves).and_return("a")
        expect{ monster.move }.to change{ monster.x }.by(-1)
        allow(subject).to receive(:possible_moves).and_return("s")
        expect{ monster.move }.to change{ monster.y }.by(1)
        allow(subject).to receive(:possible_moves).and_return("d")
        expect{ monster.move }.to change{ monster.x }.by(1)
        allow(subject).to receive(:possible_moves).and_return(nil)
        expect{ monster.move }.to change{ monster.x }.by(0)
        expect{ monster.move }.to change{ monster.y }.by(0)
      end
    end

    context "move blocked" do
      before do
        allow_any_instance_of(Interface).to receive(:blocked?) {true}
      end

      it "all possible moves result in the monster in the correct movement (none)" do
        allow(subject).to receive(:possible_moves).and_return("w")
        expect{ monster.move }.to change{ monster.y }.by(0)
        allow(subject).to receive(:possible_moves).and_return("a")
        expect{ monster.move }.to change{ monster.x }.by(0)
        allow(subject).to receive(:possible_moves).and_return("s")
        expect{ monster.move }.to change{ monster.y }.by(0)
        allow(subject).to receive(:possible_moves).and_return("d")
        expect{ monster.move }.to change{ monster.x }.by(0)
        allow(subject).to receive(:possible_moves).and_return(nil)
        expect{ monster.move }.to change{ monster.x }.by(0)
        expect{ monster.move }.to change{ monster.y }.by(0)
      end
    end

  end
end
