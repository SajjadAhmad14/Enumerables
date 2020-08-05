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
    else
      self.length.times do |i|
        yield self[i], i
      end
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

array_int.each_with_index {|(x), z| puts "Value: #{x}, #{z}."}
array_int.my_each_with_index {|(x), z| puts "Value: #{x}, #{z}."}