module Enumerable
  #MY EACH METHOD
  def my_each
    return to_enum(:my_each) unless block_given?
    for value in self
      yield value
    end
    return self
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

  #MY SELECT METHOD
  def my_select
    for i in self
      yield i
    end
  end

  #MY_ALL? METHOD
  def my_all?
    key = true
    self.length.times do |x|
      unless yield self[x]
        key = false
      end
    end
    key
  end

  #MY_ANY? METHOD
  def my_any?
    for i in self
      return true if yield i
    end
    false
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

puts array_int.any? {|x| x > 10 ? true : false ;}
puts array_int.my_any? {|x| x > 10 ? true : false ;}