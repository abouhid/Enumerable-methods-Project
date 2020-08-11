# spec/calculator_spec.rb
require './enumerable_methods.rb'

describe Enumerable do
  let(:test) { Array.new([nil, 2.5, 'hi', -7, true]) }
  let(:range) { Array.new(6) { |i| i + 1 } }
  let(:arr) { Array.new(%w[ant ant ant]) }
  let(:arr2) { Array.new(%w[ant bear shark]) }

  describe '#my_each' do
    it 'returns the elements of an array' do
      expect(test.my_each { |el| el }).to eql(test.each { |el| el })
    end
  end
  describe '#my_each_with_index' do
    it 'returns the elements of an array with index' do
      expect(test.my_each_with_index { |el| el }).to eql(test.each { |el| el })
    end
  end
  describe '#my_select' do
    it 'returns the elements of an array that are selected through a rule' do
      expect(range.my_select { |n| n > 3 }).to eql(range.select { |n| n > 3 })
    end
  end

  describe '#my_all?' do
    it 'returns the elements of an array if all of them follow a rule' do
      expect(arr.my_all? { |word| word.length >= 2 }).to eql(arr.all? { |word| word.length >= 2 })
    end
  end

  describe '#my_any?' do
    it 'returns the elements of an array if any of them follow a rule' do
      expect(arr.my_any? { |word| word.length >= 2 }).to eql(arr.any? { |word| word.length >= 2 })
    end
  end
  describe '#my_none?' do
    it 'returns the elements of an array if any of them follow a rule' do
      expect(arr.my_none? { |word| word.length >= 2 }).to eql(arr.none? { |word| word.length >= 2 })
    end
  end
  describe '#my_count' do
    it 'returns the number of times a certain element appears in an array' do
      expect(range.my_count(4)).to eql(range.count(4))
    end
  end
  describe '#my_map' do
    it 'returns the result of a function on each element of an array' do
      expect(range.my_map { |x| x * 5 }).to eql(range.map { |x| x * 5 })
    end
  end
  describe '#my_inject' do
    it 'returns the result of a function on each element of an array' do
      expect(range.my_inject(5) { |sum, el| sum + el }).to eql(range.inject(5) { |sum, el| sum + el })
    end
  end
  describe '#multiply_els' do
    it 'returns the result of a function on each element of an array' do
      expect([].multiply_els([2, 4, 5])).to eql(40)
    end
  end
end
