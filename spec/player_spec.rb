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

    let(:input) { StringIO.new("wasd") }
    it "returns the charactors entered in order" do
      $stdin = input
      expect(player.user_move).to eq("w")
      expect(player.user_move).to eq("a")
      expect(player.user_move).to eq("s")
      expect(player.user_move).to eq("d")
      $stdin = STDIN
    end

    let(:input2) { StringIO.new("fsqa") }
    it "returns the /[wasd]/ charactors entered in order" do
      $stdin = input2
      expect(player.user_move).to eq("s")
      expect(player.user_move).to eq("a")
      $stdin = STDIN
    end

    let(:input3) { StringIO.new("q")}
    it "return nothing, but runs for about 0.5s" do
      $stdin = input3
      start = Time.now
      player.user_move
      expect(Time.now - start).to be_within(0.005).of(0.5)
      $stdin = STDIN
    end

  end
end
