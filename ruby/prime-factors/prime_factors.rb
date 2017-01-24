require_relative "./sieve.rb"

class PrimeFactors

  def self.for(number)
    factor = 2
    [].tap do |factors|
      loop do
        break if number <= 1
        loop do
          break if (number % factor != 0)
          number /= factor
          factors << factor
        end
        factor += 1
      end
    end
  end

end
