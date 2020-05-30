require_relative '../lib/moveable.rb'

describe Moveable do
  let(:interface_double) { double(:interface) }
  subject(:moveable) { described_class.new(1, 1, interface_double) }

  it "should require two arguments that define its location" do
    expect(Moveable).to respond_to(:new).with(3).arguments
  end

  it "should have location parameters accessable" do
    expect(moveable.x).to eq(1)
    expect(moveable.y).to eq(1)
    moveable.x, moveable.y = 2, 2
    expect(moveable.x).to eq(2)
    expect(moveable.y).to eq(2)
  end

end
