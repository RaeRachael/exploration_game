require_relative '../lib/basic_methods.rb'

describe "basic methods" do
  
  describe "#pause" do
    
    [0.01, 0.3, 0.5].each do |length|
      it "should add a pause greater than #{length} when called with #{length}" do
        start = Time.now
        pause(length)
        finish = Time.now
        expect((finish - start > length)).to eq(true)
      end
    end
    
    [0.01, 0.3, 0.5].each do |length|
      it "should add a pause smaller than #{length} * 1.05 when called with #{length}" do
        start = Time.now
        pause(length)
        finish = Time.now
        expect((finish - start < length * 1.05)).to eq(true)
      end
    end
  end
  
  require 'io/console'
  require 'stringio'
  
  describe "#user_move" do
    let(:input) { StringIO.new("wasd") }
    it "returns the charactors entered in order" do
      $stdin = input
      expect(user_move).to eq("w")
      expect(user_move).to eq("a")
      expect(user_move).to eq("s")
      expect(user_move).to eq("d")
      $stdin = STDIN
    end
    
    let(:input2) { StringIO.new("fsqa") }
    it "returns the /[wasd]/ charactors entered in order" do
      $stdin = input2
      expect(user_move).to eq("s")
      expect(user_move).to eq("a")      
      $stdin = STDIN
    end
  end
end