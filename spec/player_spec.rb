require_relative '../lib/moveable.rb'

describe Player do
  subject(:player) { described_class.new(1,1) }

  describe "should inherit properties from Moveable" do

    it "should require two arguments that define its location" do
      expect(Player).to respond_to(:new).with(2).arguments
    end

    it "should have location parameters accessable" do
      expect(player.x).to eq(1)
      expect(player.y).to eq(1)
      player.x, player.y = 2,2
      expect(player.x).to eq(2)
      expect(player.y).to eq(2)
    end

    it "should have a way to interface with other
    classes using an instance of Interface" do
      expect(player.interface).to be_an_instance_of(Interface)
    end
  end

  describe "#user_move" do

    require 'io/console'
    require 'stringio'

    it "return nothing, but runs for about 0.5s" do
      allow_any_instance_of(IO).to receive(:getch) { sleep(5) }
      start = Time.now
      player.user_move
      expect(Time.now - start).to be_within(0.05).of(0.5)
    end
  end

  describe "#move" do
    context "no blocking tile" do
      before do
        allow_any_instance_of(Interface).to receive(:blocked?) {false}
      end

      let(:input2) { StringIO.new("fsqawdp") }
      it "returns the /[wasdp]/ charactors entered in order,
      and moves in the player in the correct way" do
        $stdin = input2
        expect{ player.move }.to change{ player.y }.by(1)  # s
        expect{ player.move }.to change{ player.x }.by(-1) # a
        expect{ player.move }.to change{ player.y }.by(-1) # w
        expect{ player.move }.to change{ player.x }.by(1)  # d
        expect(player.user_move).to eq("p") # pause menu not yet created
        $stdin = STDIN
      end
    end

    context "blocking tile" do
      before do
        allow_any_instance_of(Interface).to receive(:blocked?) {true}
      end

      let(:input2) { StringIO.new("fsqawdp") }
      it "returns the /[wasdp]/ charactors entered in order,
      and moves in the player in the correct way" do
        $stdin = input2
        expect{ player.move }.to change{ player.y }.by(0)  # s
        expect{ player.move }.to change{ player.x }.by(0) # a
        expect{ player.move }.to change{ player.y }.by(0) # w
        expect{ player.move }.to change{ player.x }.by(0)  # d
        expect(player.user_move).to eq("p") # pause menu not yet created
        $stdin = STDIN
      end
    end

  end
end
