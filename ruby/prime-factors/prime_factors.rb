class PrimeFactors

  def self.for(number)
    factor = 2
    factors = []
    loop do
      break if number <= 1
      loop do
        break if (number % factor != 0)
        number /= factor
        factors << factor
      end
      factor += 1
    end
    factors
  end

end
