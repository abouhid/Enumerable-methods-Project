# spec/calculator_spec.rb
require_relative '../enumerable_methods.rb'

describe Enumerable do
  let(:test) { Array.new([nil, 2.5, 'hi', -7, true]) }
  let(:arr_i) { Array.new(6) { |i| i + 1 } }
  let(:arr_s) { Array.new(%w[ant ant ant]) }
  let(:has) { { a: 10, b: 20 } }
  let(:range) { (2..10) }
  let(:proc_case) { proc { |x| x * 4 } }

  describe ' #my_each' do
    it 'returns the elements of an array' do
      expect(test.my_each.to_a).to eql(test.each.to_a)
    end
    it 'returns the elements of an array which presents a block' do
      expect(arr_i.my_each.to_a { |el| el + 4 }).to eql(arr_i.each.to_a { |el| el + 4 })
    end
    it 'returns the elements of a range' do
      expect(range.my_each.to_a).to eql(range.each.to_a)
    end
    it 'returns the elements of a hash' do
      expect(has.my_each.to_a).to eql(has.each.to_a)
    end
  end
  describe ' #my_each_with_index' do
    it 'returns the elements of an array with index' do
      expect(test.my_each_with_index.to_a { |el, i| }).to eql(test.each_with_index.to_a { |el, i| })
    end
    it 'returns the elements of an array with index' do
      expect(range.my_each_with_index.to_a).to eql(range.each_with_index.to_a)
    end
    it 'returns the elements of an array with index' do
      expect(has.my_each_with_index.to_a).to eql(has.each_with_index.to_a)
    end
  end
  describe ' #my_select' do
    it 'returns the elements of an array that are selected if they pass a condition' do
      expect(arr_i.my_select { |n| n > 3 }).to eql(arr_i.select { |n| n > 3 })
    end
    it 'returns the elements of a range that are selected if they pass a condition' do
      expect(range.my_select { |n| n > 3 }).to eql(range.select { |n| n > 3 })
    end
    it 'returns Enumerator if no block is given' do
      expect(arr_i.my_select).to be_an Enumerator
    end
    it 'Since 8, 9, 10 are within our range, it is expected for it not to be empty' do
      expect(range.my_select { |n| n > 7 }).not_to be_empty
    end
  end

  describe ' #my_all?' do
    it 'returns the elements of an array if all of them pass a condition when a block is given' do
      expect(arr_s.my_all? { |word| word.length >= 2 }).to eql(arr_s.all? { |word| word.length >= 2 })
    end
    it 'returns the elements of an array if all of them pass a condition when no block is given' do
      expect(arr_s.my_all?('ant')).to eql(arr_s.all?('ant'))
    end
    it 'Does not return the same result if .all? presents a different argument' do
      expect(arr_s.my_all? { |word| word.length >= 2 }).not_to eql(arr_s.all? { |word| word == 'sharks' })
    end
  end

  describe ' #my_any?' do
    it 'returns the elements of an array if any of them pass a condition when a block is given' do
      expect(arr_s.my_any? { |word| word.length >= 2 }).to eql(arr_s.any? { |word| word.length >= 2 })
    end
    it 'returns the elements of an array if any of them pass a condition when no block is given' do
      expect(arr_s.my_any?('ant')).to eql(arr_s.any?('ant'))
    end
    it 'Does not return the same result if .all? presents a different argument' do
      expect(arr_s.my_all? { |word| word.length >= 2 }).not_to eql(arr_s.all? { |word| word == 'sharks' })
    end
  end
  describe ' #my_none?' do
    it 'returns the elements of an array if none of them pass a condition when a block is given' do
      expect(arr_s.my_none? { |word| word.length >= 2 }).to eql(arr_s.none? { |word| word.length >= 2 })
    end
    it 'returns the elements of an array if none of them pass a condition when no block is given' do
      expect(arr_s.my_none?('ant')).to eql(arr_s.none?('ant'))
    end
    it 'Expected to not be true when the condition passes in all elements' do
      expect(arr_s.my_none? { |word| word.length >= 2 }).not_to be true
    end
  end
  describe ' #my_count' do
    it 'returns the number of times a certain element appears in an array when given an argument' do
      expect(arr_i.my_count(2)).to eql(arr_i.count(2))
    end
    it 'returns the number of times a certain element appears in a hash, when given argument' do
      expect(has.my_count).to eql(has.count)
    end
    it 'returns the number of times a certain element appears in an array' do
      expect(arr_i.my_count { |n| n > 4 }).to eql(arr_i.count { |n| n > 4 })
    end
    it 'Expects the result to be an Integer, not a String' do
      expect(arr_i.my_count { |n| n > 4 }).not_to be_an String
    end
  end

  describe ' #my_map' do
    it 'returns the array with its elements modified when a block is given' do
      expect(arr_i.my_map { |x| x * 5 }).to eql(arr_i.map { |x| x * 5 })
    end
    it 'returns the range with its elements modified when a proc is given' do
      expect(range.my_map(&proc_case)).to eql(range.map(&proc_case))
    end
    it 'Expects to not include a negative random number when array is elevated to 3' do
      expect(arr_i.my_map { |x| x**2 }).not_to include(-100 * rand)
    end
  end
  describe ' #my_inject' do
    it 'Combines all elements of array by applying a binary operation, specified by a block' do
      expect(arr_i.my_inject(5) { |sum, el| sum + el }).to eql(arr_i.inject(5) { |sum, el| sum + el })
    end
    it 'Combines all elements of array by applying a binary operation, using a string as a condition' do
      expect(arr_i.my_inject('+')).to eql(arr_i.inject('+'))
    end
    it 'Combines all elements of array by applying a binary operation, using a symbol as a condition' do
      expect(arr_i.my_inject(:-)).to eql(arr_i.inject(:-))
    end
    it 'Combines all elements o a range by applying a binary operation, using a symbol and an argument as conditions' do
      expect(range.my_inject(5, :-)).to eql(range.inject(5, :-))
    end
    it 'Expected for the result when the argument is 5 and \'-\' symbol to be -49, not 100' do
      expect(range.my_inject(5, :-)).not_to be 100
    end
  end
  describe '#multiply_els' do
    it 'returns the result of a function on each element of an array' do
      expect([].multiply_els([2, 4, 5])).to eql(40)
    end
  end
end
