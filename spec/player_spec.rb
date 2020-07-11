require_relative '../lib/moveable.rb'

describe Player do
  let(:interface_double) { double(:interface) }
  subject(:player) { described_class.new(1, 1, interface_double) }

  describe "should inherit properties from Moveable" do

    it "should require two arguments that define its location" do
      expect(Player).to respond_to(:new).with(3).arguments
    end

    it "should have location parameters accessable" do
      expect(player.x).to eq(1)
      expect(player.y).to eq(1)
      player.x, player.y = 2, 2
      expect(player.x).to eq(2)
      expect(player.y).to eq(2)
    end

  end

  describe "#user_move" do

    require 'io/console'
    require 'stringio'

    it "getch method doesn't wait for 0.5s" do
      allow_any_instance_of(IO).to receive(:getch) { sleep(5) }
      expect { Timeout::timeout(0.5) { player.read_move } }.to_not raise_error
    end
  end

  describe "#move" do
    context "no blocking tile" do
      before do
        allow(interface_double).to receive(:blocked?) { false }
      end

      let(:input2) { StringIO.new("fsqawdp") }
      it "returns the /[wasdp]/ charactors entered in order,
      and moves in the player in the correct way" do
        $stdin = input2
        expect{ player.move }.to change{ player.y }.by(1) # s
        expect{ player.move }.to change{ player.x }.by(-1) # a
        expect{ player.move }.to change{ player.y }.by(-1) # w
        expect{ player.move }.to change{ player.x }.by(1) # d
        expect(player.user_move).to eq("p") # pause menu not yet created
        $stdin = STDIN
      end
    end

    context "blocking tile" do
      before do
        allow(interface_double).to receive(:blocked?) { true }
      end

      let(:input2) { StringIO.new("fsqawdp") }
      it "returns the /[wasdp]/ charactors entered in order,
      and moves in the player in the correct way" do
        $stdin = input2
        expect{ player.move }.to change{ player.y }.by(0) # s
        expect{ player.move }.to change{ player.x }.by(0) # a
        expect{ player.move }.to change{ player.y }.by(0) # w
        expect{ player.move }.to change{ player.x }.by(0) # d
        expect{ player.move }.to raise_error( SystemExit ) # pause menu not yet created
        $stdin = STDIN
      end
    end

  end
end
