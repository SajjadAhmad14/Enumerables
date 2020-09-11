# This file contains spec tests for Enumerable methods

require '../enum.rb'
describe Enumerable do
  let(:empty_array) { [] }
  let(:array) { [1, 2, 3, 4] }
  let(:hash) { { 'name' => 'name1', 'cast' => 'Sardar' } }
  let(:range) { (1..4) }
  describe '#my_each' do
    it 'return each element of an array' do
      expect(array.my_each { |element|}).to eql([1, 2, 3, 4])
    end
    it 'return each element of an hash' do
      expect(hash.my_each { |key, value| }).to eql({'name' => 'name1', 'cast' => 'Sardar'})
    end
    it 'return each element of a range' do
      expect(range.my_each { |element| }).to eql((1..4))
    end
  end

  describe '#my_each_with_index' do
    it 'return each element of an array and its corresponding index' do
      expect(array.my_each_with_index { |element, index| }).to eql([1, 2, 3, 4])
    end
    it 'return each element of an hash and its corresponding index' do
      expect(hash.my_each_with_index { |element, index| }).to eql({'name' => 'name1', 'cast' => 'Sardar'})
    end
    it 'return each element of a range and its corresponding index' do
      expect(range.my_each_with_index { |element, index| }).to eql(1..4)
    end
  end

  describe '#my_select' do
    it 'returns each element for which condition is true' do
      expect(array.my_select { |i| i > 2 }).to eql([3, 4])
    end
  end

  describe '#my_all?' do
    it 'return true if all of the elements are true for condition' do
      expect(array.my_all? { |element| element >= 1 }).to eql(true)
    end
    it 'return false if all of the elements are false for condition' do
      expect(array.my_all? { |element| element > 2 }).to eql(false)
    end
    it 'return false if even one element has a nil value' do
      expect([nil, 1, true, 'sajjad'].my_all?).to eql(false)
    end
    it 'return true when method is called on empty array and no block is passed to method' do
      expect(empty_array.my_all?).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'returns true if any element is true to condition' do
      expect(array.my_any? { |element| element > 2 }).to eql(true)
    end
    it 'returns false if any element is false to condition' do
      expect(array.my_any? { |element| element > 4 }).to eql(false)
    end
    it 'returns false if method is called on empty array and no block is passed' do
      expect(empty_array.my_any?).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'true if condition false for all elements' do
      expect(array.my_none? { |element| element < 0 }).to eql(true)
    end
    it 'false if condition true for any element' do
      expect(array.my_none? { |element| element > 3 }).to eql(false)
    end
    it 'true if array is empty and no block passed' do
      expect(empty_array.my_none?).to eql(true)
    end
  end

  describe '#my_count' do
    it 'count array elements' do
      expect(array.my_count).to eql(4)
    end
    it 'total number against the passed argument' do
      expect(array.my_count).to eql(4)
    end
    it 'total number for condition true' do
      expect(array.my_count { |e| e > 1 }).to eql(3)
    end
  end

  describe '#my_map' do
    it 'returns a new array based on the block given' do
      expect(array.my_map { |e| e + 1 }).to eql([2, 3, 4, 5])
    end
    it 'returns an enumerator if no block given' do
      expect(array.my_map).to be_an Enumerator
    end
  end

  describe '#my_inject' do
    it 'returns a combined result when block is passed' do
      expect(array.my_inject { |product, e| product * e }).to eql(24)
    end
    it 'returns combined result when a symbol is passed' do
      expect(array.my_inject(:+)).to eql(10)
    end
    it 'combine result when a block and initial value is passed' do
      expect(array.my_inject(1) { |product, e| product * e }).to eql(24)
    end
  end
end
