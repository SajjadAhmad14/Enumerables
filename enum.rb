module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    size.times do |x|
      yield to_a[x]
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    j = 0
    size.times do |x|
      yield to_a[x], j
      j += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    if self.class == Hash
      size.times do |x|
        to_a[x] if yield to_a[x]
      end
      self
    else
      n = []
      size.times do |x|
        n.push(to_a[x]) if yield to_a[x]
      end
      n
    end
  end

  def my_all?(pattern = nil)
    if ((block_given? == false) && pattern.nil? == true)
      length.times do |x|
        return false if ((self[x] == false) || (self[x] == nil))
      end
      return true
    end

    unless pattern.nil?
      if pattern.class == Regexp
        length.times do |x|
          return false if !pattern.match(self[x])
        end
      else
        length.times do |x|
          return false if self[x].class != pattern
        end
      end
      true
    else
      length.times do |x|
        return false unless yield self[x]
      end
      true
    end
  end

  def my_any?
    length.times do |x|
      return true if yield self[x]
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
        new_array.push(yield(self[x]))
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

my_arr = ['usa']
my_range = (1..5)
my_hash = {"sajjad" => 1, "tadue" => 2}

puts my_arr.all? {|x| x.is_a?(String)}
puts my_arr.my_all? {|x| x.is_a?(String)}
