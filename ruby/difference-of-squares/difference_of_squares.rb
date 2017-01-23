class Squares

  def initialize(val)
    @value = val
    @range = (1..@value).to_a
  end

  def square_of_sum
    @square_of_sum ||=
      begin
        sum = @range.inject(:+).to_i
        sum ** 2
      end
  end

  def sum_of_squares
    @sum_of_squares ||= @range.map{|x| x*x}.inject(:+).to_i
  end

  def difference
    square_of_sum - sum_of_squares
  end

end

module BookKeeping
  VERSION = 3 # Where the version number matches the one in the test.
end