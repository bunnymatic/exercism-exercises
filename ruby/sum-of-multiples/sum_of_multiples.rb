class SumOfMultiples

  def initialize(*args)
    @factors = args
  end

  def to(limit)
    (1..limit-1).reduce(0) do |memo, val|
      memo += val if is_a_multiple?(val)
      memo
    end
  end

  private
  def is_a_multiple?(val)
    @factors.any? { |f| val % f == 0 }
  end

end