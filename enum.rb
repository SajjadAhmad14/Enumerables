module Enumerable
  #MY EACH METHOD
  def my_each
    for value in self
      yield value
    end
  end

  #MY EACH WITH INDEX METHOD
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

  #MY EACH WITH INDEX METHOD
  def my_select
    for i in self
      yield i
    end
  end
end

#DECLARE VARIABLES AND CALL FUNCTIONS BELOW
array_int = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0]
array_str = %w[tadeu sajjad brazil pakistan microverse ruby]
hash_first = {
  :keyone => 'firstvalue',
  :keytwo => 'secondvalue',
  :keythree => 'thirdvalue',
  :keyfour => 'fourthvalue'
}
my_range = (1..9)
hash_first.select do |i, j|
  if i == :keytwo
    puts j
  end
end
puts
hash_first.my_select do |i, j|
  if i == :keytwo
    puts j
  end
end