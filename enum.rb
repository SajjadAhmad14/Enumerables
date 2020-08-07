module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    length.times do |x|
      yield self[x]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?
    case self
    when Hash
      j = 0
      length.times do |x|
        yield self[x], j
        j += 1
      end
    when Array
      length.times do |i|
        yield self[i], i
      end
    else
      k = 0
      length.times do |x|
        yield self[x], k
        k += 1
      end
    end
  end

  def my_select
    n = []
    length.times do |x|
      n.push(self[x]) if yield self[x]
    end
    n
  end

  def my_all?
    key = true
    length.times do |x|
      key = false unless yield self[x]
    end
    key
  end

  def my_any?
    length.times do |x|
      return true if yield[x]
    end
    false
  end

  def my_none?
    length.times do |x|
      return false if yield self[x]
    end
    true
  end

  def my_count(*key)
    if key.length.positive?
      counter = 0
      length.times do |x|
        counter += 1 if self[x] == key[0]
      end
      return counter
    elsif block_given?
      counter = 0
      length.times do |x|
        counter += 1 if yield self[x]
      end
      return counter
    end
    length
  end

  def my_map(proc = nil)
    new_array = []
    if proc.nil?
      length.times do |x|
        new_array_push(yield(self[x]))
      end
    else
      length.times do |x|
        new_array.push(proc.call(self[x]))
      end
    end
    new_array
  end

  def my_inject
    counter = self[0]
    length.times do |x|
      next if x.zero?

      counter = yield(counter, self[x])
    end
    counter
  end
end

def multiply_els(arr)
  arr.my_inject { |x, y| x * y }
end

# ar = [1, 2, 3, 4]
# puts ar.my_select{|x| x.even?}