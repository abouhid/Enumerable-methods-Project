# spec/calculator_spec.rb
require './enumerable_methods.rb'

describe Enumerable do
  let(:test) { Array.new([nil, 2.5, 'hi', -7, true]) }
  let(:arr_i) { Array.new(6) { |i| i + 1 } }
  let(:arr_s) { Array.new(%w[ant ant ant]) }
  let(:has) { { a: 10, b: 20 } }
  let(:range) { (2..10) }
  let(:proc_case) { proc { |x| x * 4 } }

  describe '#my_each' do
    it 'returns the elements of an array' do
      expect(test.my_each.to_a).to eql(test.each.to_a)
    end
    it 'returns the elements of an array which presents a block' do
      expect(test.my_each.to_a {|el| el+4}).to eql(test.each.to_a {|el| el+4})
    end
    it 'returns the elements of a range' do
      expect(range.my_each.to_a).to eql(range.each.to_a)
    end
    it 'returns the elements of a hash' do
      expect(has.my_each.to_a).to eql(has.each.to_a)
    end
  end
  describe '#my_each_with_index' do
    it 'returns the elements of an array with index' do
      expect(test.my_each_with_index.to_a{|el,i|}).to eql(test.each_with_index.to_a{|el,i|})
    end
    it 'returns the elements of an array with index' do
      expect(range.my_each_with_index.to_a).to eql(range.each_with_index.to_a)
    end
    it 'returns the elements of an array with index' do
      expect(has.my_each_with_index.to_a).to eql(has.each_with_index.to_a)
    end
  end
  describe '#my_select' do
    it 'returns the elements of an array that are selected if they pass a condition' do
      expect(arr_i.select { |n| n > 3 }).to eql(arr_i.my_select { |n| n > 3 })
    end
  end

  describe '#my_all?' do
    it 'returns the elements of an array if all of them pass a condition' do
      expect(arr_s.my_all? { |word| word.length >= 2 }).to eql(arr_s.all? { |word| word.length >= 2 })
    end
  end

  describe '#my_any?' do
    it 'returns the elements of an array if any of them pass a condition' do
      expect(arr_s.my_any? { |word| word.length >= 2 }).to eql(arr_s.any? { |word| word.length >= 2 })
    end
  end
  describe '#my_none?' do
    it 'returns the elements of an array if none of them pass a condition' do
      expect(arr_s.my_none? { |word| word.length >= 2 }).to eql(arr_s.none? { |word| word.length >= 2 })
    end
  end
  describe '#my_count' do
    it 'returns the number of times a certain element appears in an array when given an argument' do
      expect(arr_i.my_count(2)).to eql(arr_i.count(2))
    end
    it 'returns the number of times a certain element appears in a hash, when given argument' do
      expect(has.my_count).to eql(has.count)
    end
    it 'returns the number of times a certain element appears in an array' do
      expect(arr_i.my_count { |n| n > 4 }).to eql(arr_i.count { |n| n > 4 })
    end
  end

  describe '#my_map' do
    it 'returns the array with its elements modified' do
      expect(arr_i.my_map { |x| x * 5 }).to eql(arr_i.map { |x| x * 5 })
    end
  end
  describe '#my_inject' do
    it 'Combines all elements of array by applying a binary operation, specified by a block' do
      expect(arr_i.my_inject(5) { |sum, el| sum + el }).to eql(arr_i.inject(5) { |sum, el| sum + el })
    end
  end
  describe '#multiply_els' do
    it 'returns the result of a function on each element of an array' do
      expect([].multiply_els([2, 4, 5])).to eql(40)
    end
  end
end
