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
end