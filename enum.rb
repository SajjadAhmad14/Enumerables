module Enumerable
  
  def my_each
    return to_enum(:my_each) unless block_given?
    for value in self
      yield value
    end
    return self
  end

  def my_each_with_index
    case self
    when Hash
      j = 0
      for i in self
        yield i, j
        j += 1
      end
    when Array
      self.length.times do |i|
        yield self[i], i
      end
    else
      k = 0
      for i in self
        yield i, k
        k += 1
      end
    end
  end

  def my_select
    for i in self
      yield i
    end
  end

  def my_all?
    key = true
    self.length.times do |x|
      unless yield self[x]
        key = false
      end
    end
    key
  end

  def my_any?
    for i in self
      return true if yield i
    end
    false
  end

  def my_none?
    self.length.times do |x|
      return false if yield self[x]
    end
    true
  end

  def my_count(*key)
    if key.length > 0
      counter = 0
      self.length.times do |x|
        counter += 1 if self[x] == key[0]
      end
      return counter
    elsif block_given?
      counter = 0
      self.length.times do |x|
        counter += 1 if yield self[x]
      end
      return counter
    end
    self.length
  end

  def my_map(proc = nil)
    new_array = Array.new
    if proc.nil?
      for i in self
        new_array.push(yield(i))
      end
      new_array
    else
      for i in self
        new_array.push(proc.call(i))
      end
      new_array
    end
  end

  def my_map_proc()
    n = []
    for i in self
      n.push(proc.call(i))
    end
    n
  end

  def my_inject
    counter = self[0]
    for x in (1...self.length)
      counter = yield(counter, self[x])
    end
    counter
  end

end

def multiply_els(ar)
    ar.my_inject {|x, y| x * y}
end
