module Enumerable  
  def my_each
    for value in self
      yield value
    end
  end

  ar = {"sajjad": 1, "Tadue": 2}
  ar.my_each {|n| puts n}

end