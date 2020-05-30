require_relative '../../lib/tile.rb'

describe Empty do
  let(:interface_double) { double(:interface) }
  let(:subject) { Empty.new(interface_double) }
  describe '#string' do
    it 'should have "   " representation' do
      expect(subject.string).to eq("   ")
    end
  end
end
