require_relative '../lib/moveable.rb'

describe Moveable do
  subject(:moveable) { described_class.new(1,1) }

  it "should require two arguments that define its location" do
    expect(Moveable).to respond_to(:new).with(2).arguments
  end

  it "should have location parameter accessable" do
    expect(moveable.x).to eq(1)
    expect(moveable.y).to eq(1)
    moveable.x, moveable.y = 2,2
    expect(moveable.x).to eq(2)
    expect(moveable.y).to eq(2)
  end
end
