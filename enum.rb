# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
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
    if block_given? == false && pattern.nil? == true
      to_a.size.times do |x|
        return false if to_a[x] == false || to_a[x].nil?
      end
      return true
    end

    if pattern.nil?
      size.times do |x|
        return false unless yield to_a[x]
      end
    elsif pattern.class == Regexp
      to_a.size.times do |x|
        return false if to_a[x].is_a?(String) && !pattern.match(to_a[x])
      end
    elsif pattern.class == Class
      to_a.size.times do |x|
        return false unless to_a[x].is_a?(pattern)
      end
    else
      to_a.size.times do |x|
        return false if to_a[x] != pattern
      end
    end
    true
  end

  def my_any?(pattern = nil)
    if block_given? == false && pattern.nil? == true
      to_a.size.times do |x|
        return true unless to_a[x] == false || to_a[x].nil?
      end
      return false
    end

    if pattern.nil?
      to_a.size.times do |x|
        return true if yield to_a[x]
      end
    elsif pattern.class == Regexp
      to_a.size.times do |x|
        return true if to_a[x].is_a?(String) && pattern.match(to_a[x])
      end
    elsif pattern.class == Class
      to_a.size.times do |x|
        return true if to_a[x].is_a?(pattern)
      end
    else
      to_a.size.times do |x|
        return true if to_a[x] == pattern
      end
    end
    false
  end

  def my_none?(pattern = nil)
    if block_given? == false && pattern.nil? == true
      to_a.size.times do |x|
        return false unless to_a[x] == false || to_a[x].nil?
      end
      return true
    end

    if pattern.nil?
      to_a.size.times do |x|
        return false if yield to_a[x]
      end
    elsif pattern.class == Regexp
      to_a.size.times do |x|
        return false if to_a[x].is_a?(String) && pattern.match(to_a[x])
      end
    elsif pattern.class == Class
      to_a.size.times do |x|
        return false if to_a[x].is_a?(pattern)
      end
    else
      to_a.size.times do |x|
        return false if to_a[x] == pattern
      end
    end
    true
  end

  def my_count(*key)
    if key.length.positive?
      counter = 0
      size.times do |x|
        counter += 1 if self[x] == key[0]
      end
      return counter
    elsif block_given?
      counter = 0
      size.times do |x|
        counter += 1 if yield to_a[x]
      end
      return counter
    end
    size
  end

  def my_map(proc = nil)
    return to_enum(:my_map) unless block_given?

    new_array = []
    if proc.nil?
      size.times do |x|
        new_array.push(yield to_a[x])
      end
    else
      size.times do |x|
        new_array.push(proc.call(to_a[x]))
      end
    end
    new_array
  end

  def my_inject(arg1 = nil, arg2 = nil)
    if !arg1.nil? && !arg2.nil?
      memo = arg1

      to_a.size.times do |x|
        memo = memo.send(arg2.to_s, to_a[x])
      end
    elsif arg1.is_a?(Numeric) && block_given?
      memo = arg1

      to_a.size.times do |x|
        memo = yield(memo, to_a[x])
      end
    elsif arg1.is_a?(Symbol)
      memo = to_a[0]

      to_a.size.times do |x|
        next if x.zero?

        memo = memo.send(arg1.to_s, to_a[x])
      end
    else
      memo = to_a[0]

      to_a.size.times do |x|
        next if x.zero?

        memo = yield(memo, to_a[x])
      end
    end
    memo
  end
end
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
