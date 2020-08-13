module Enumerable
  def my_each
    return to_enum unless block_given?

    for x in self
      yield(x)
    end
  end

  def my_each_with_index
    return enum_for(__callee__) unless block_given?

    size.times { |i| yield(to_a[i], i) }
    self
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    my_each do |el|
      arr << el if yield(el) == true
    end
    arr
  end

  def my_all?(*arg)
    i = 0
    if block_given?
      my_each do |el|
        i += 1 if yield(el) == true
      end
    elsif arg[0] == Integer || arg[0] == Float || arg[0] == String
      my_each do |el|
        i += 1 if el.class == arg[0]
      end
    elsif arg[0].class == Regexp
      arr = to_a
      i = 0
      arr.size.times do |l|
        if arg[0].match(arr[l])
          i += 1
          return true if i == arr.length
        end
      end
    elsif arg[0].nil?
      my_each do |el|
        i += 1 if el != false && !el.nil?
      end
    else
      my_each do |el|
        i += 1 if el == arg[0]
      end
    end
    i == size
  end

  def my_any?(*arg)
    i = 0
    if block_given?
      my_each do |el|
        i += 1 if yield(el) == true
      end
    elsif arg[0] == Integer || arg[0] == Float || arg[0] == String
      my_each do |el|
        i += 1 if el.class == arg[0]
      end
    elsif arg[0].class == Regexp
      arr = to_a
      i = 0
      arr.size.times do |l|
        if arg[0].match(arr[l])
          i += 1
          return true if i.positive?
        end
      end
    elsif arg[0].nil?
      my_each do |el|
        i += 1 if el != false && !el.nil?
      end
    else
      my_each do |el|
        i += 1 if el == arg[0]
      end
    end
    i.positive?
  end

  def my_none?(*arg)
    i = 0
    if block_given?
      my_each do |el|
        i += 1 if yield(el) != true
      end
    elsif arg[0] == Integer || arg[0] == Float || arg[0] == String
      my_each do |el|
        i += 1 if el.class != arg[0]
      end
    elsif arg[0].class == Regexp
      arr = to_a
      i = 0

      arr.size.times do |l|
        if arg[0].match(arr[l])
          i += 1
          return false if i.positive?
        end
      end
    elsif arg[0].nil?
      my_each do |el|
        i += 1 if el == false || el.nil?
      end
    else
      my_each do |el|
        i += 1 if el != arg[0]
      end
    end
    i == size
  end

  def my_count(*arg)
    counter = 0
    if block_given?
      my_each do |el|
        counter += 1 if yield(el) == true
      end
      counter
    elsif arg.empty?
      size
    else
      my_each do |el|
        counter += 1 if el == arg[0]
      end
      counter
    end
  end
end

module Enumerable
  def my_map(*_arg)
    return to_enum unless block_given?

    i = 0
    arr = []
    my_each do |el|
      arr[i] = yield(el)
      i += 1
    end
    arr
  end

  def my_inject(num = nil, sym = nil)
    arr = to_a

    if block_given?
      if !num.nil?
        my_each do |el|
          num = yield(num, el)
        end

      else
        num = arr[0]
        arr[1..-1].my_each do |el|
          num = yield(num, el)
        end
      end
      num
    elsif !block_given?
      if num.class == Symbol || num.class == String
        sum = nil
        my_each { |i| sum = sum.nil? ? i : sum.send(num, i) }
        sum
      elsif !sym.nil?
        if sym.class == Symbol || sym.class == String
          sum = num
          my_each { |i| sum = sum.send(sym, i) }
          sum
        end
      else
        "#{num} is not a symbol nor a string (TypeError)"
      end
    end
  end

  def multiply_els(arr)
    arr.my_inject(:*)
  end
end
