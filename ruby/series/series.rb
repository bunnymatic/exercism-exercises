class Series

  def initialize(val)
    @value = val
  end

  def slices(n)
    raise ArgumentError unless is_valid_number_of_slices?(n)

    result = []
    @value.chars.each_cons(n) { |chars| result << chars.join }
    result
  end

  def is_valid_number_of_slices?(n)
    (n <= @value.length)
  end
end

module BookKeeping
  VERSION=1
end