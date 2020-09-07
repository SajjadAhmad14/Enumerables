require '../enum.rb'

describe Enumerable do
  let (:array) {[1, 2, 3]}
  describe '#my_each' do
    it "return each element of an array" do
      expect(array.my_each{|element|}).to eql(array.my_each{|element|})
    end
  end

  describe '#my_each_with_index' do
    it "return each element and it corresponding index" do
      expect(array.my_each_with_index{|element, index|}).to eql(array.my_each_with_index{|element, index|})
    end
  end

  
end