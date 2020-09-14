# This file contains spec tests for Enumerable methods

require_relative '../enum.rb'
describe Enumerable do
  let(:empty_array) { [] }
  let(:array) { [1, 2, 3, 4] }
  let(:hash) { { 'name' => 'Sajjad', 'cast' => 'Sardar' } }
  let(:range) { (1..4) }
  describe '#my_each' do
    it 'return an enumerator if no block given' do
      expect(array.my_each).to be_an Enumerator
    end
    it 'return an array when a block is passed' do
      result = []
      array.my_each { |element| result << element + 1 }
      expect(result).to eql([2, 3, 4, 5])
    end
    it 'return an hash when a block is passed' do
      result = {}
      hash.my_each { |key, value| result.store('my ' + key, value) }
      expect(result).to eql({ 'my name' => 'Sajjad', 'my cast' => 'Sardar' })
    end
    it 'return a range when a block is passed' do
      result = []
      range.my_each { |element| result << element * 2 }
      expect(result).to eql([2, 4, 6, 8])
    end
  end

  describe '#my_each_with_index' do
    it 'return an enumerator if no block given' do
      expect(array.my_each).to be_an Enumerator
    end
    it 'return an array when a block is passed' do
      result = []
      array.my_each_with_index { |element, _index| result << element - 1 }
      expect(result).to eql([0, 1, 2, 3])
    end
    it 'return an hash with indexes when a block is passed' do
      result = {}
      hash.my_each_with_index { |key, value| result.store(key, value) }
      expect(result).to eql({ ['name', 'Sajjad'] => 0, ['cast', 'Sardar'] => 1 })
    end
    it 'return a range when a block is passed' do
      result = []
      range.my_each_with_index { |element, _index| result << element + 2 }
      expect(result).to eql([3, 4, 5, 6])
    end
  end

  describe '#my_select' do
    it 'return an enumerator if no block given' do
      expect(array.my_select).to be_an Enumerator
    end
    it 'return an array when a block is given' do
      expect(array.my_select(&:even?)).to eql([2, 4])
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
    it 'return false when regex is not present in all the elements' do
      expect(%w[I am Sajjad].my_all?(/a/)).to eql(false)
    end
    it 'return true or false when a class is passed' do
      expect(['I', 'am', 25].my_all?(Integer)).to eql(false)
      expect(%w[I am Sajjad].my_all?(String)).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'return true if any element is true to condition' do
      expect(array.my_any? { |element| element > 2 }).to eql(true)
    end
    it 'return false if any element is false to condition' do
      expect(array.my_any? { |element| element > 4 }).to eql(false)
    end
    it 'return false if method is called on empty array and no block is passed' do
      expect(empty_array.my_any?).to eql(false)
    end
    it 'return true or false when a regex is passed' do
      expect(%w[I am Sajjad].my_any?(/a/)).to eql(true)
      expect(%w[I am Sajjad].my_any?(/z/)).to eql(false)
    end
    it 'return true or false when a class is passed' do
      expect(['I', 'am', 25].my_any?(Integer)).to eql(true)
      expect(%w[I am Sajjad].my_any?(Integer)).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'return true if condition false for all elements' do
      expect(array.my_none? { |element| element < 0 }).to eql(true)
    end
    it 'return false if condition true for any element' do
      expect(array.my_none? { |element| element > 3 }).to eql(false)
    end
    it 'return true if array is empty and no block passed' do
      expect(empty_array.my_none?).to eql(true)
    end
    it 'return true or false when a regex is passed' do
      expect(%w[I am Sajjad].my_none?(/z/)).to eql(true)
      expect(%w[I am Sajjad].my_none?(/a/)).to eql(false)
    end
    it 'return true or false when a class is passed' do
      expect(['I', 'am', 25].my_none?(Integer)).to eql(false)
      expect(%w[I am Sajjad].my_none?(Integer)).to eql(true)
    end
  end

  describe '#my_count' do
    it 'return total count of array' do
      expect(array.my_count).to eql(4)
    end
    it 'return total count array elements which are equal to passed argument' do
      expect(array.my_count(2)).to eql(1)
    end
    it 'return total count array elements for which given block is given' do
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
    it 'return a combined result when block is passed' do
      expect(array.my_inject { |product, e| product * e }).to eql(24)
    end
    it 'return combined result when a symbol is passed' do
      expect(array.my_inject(:+)).to eql(10)
    end
    it 'return combine result when a block and initial value is passed' do
      expect(array.my_inject(1) { |product, e| product * e }).to eql(24)
    end
    it 'return combine result when a symbol and an initial value is passed' do
      expect(array.my_inject(1, :+)).to eql(11)
    end
  end

  describe '#multiply_els(array)' do
    it 'return result after calling inject on parameter' do
      expect(array.inject(:*)).to eql(24)
    end
  end
end
