class Sieve
  def initialize(val)
    @value = val
  end

  def primes
    numbers = Hash[ (2..@value).map{ |x| [x, true] } ]
    nn = Math.sqrt(@value).ceil.to_i
    numbers.keys.select{|k| k < nn}.each do |ii|
      if numbers[ii]
        jj = ii**2
        loop do
          numbers[jj] = false
          jj += ii
          break if jj > @value
        end
      end
    end
    numbers.select{|k,v| v}.keys
  end

end

class Prime

  FIRST_PRIMES = [1] + Sieve.new(100000).primes

  def self.nth(val)
    raise ArgumentError.new("There is no zeroth prime") unless val > 0
    cap = [ 100, (2 * val * Math.log(val) )].max.to_i
    primes = Sieve.new(cap).primes
    primes[val - 1]
  end

end

module BookKeeping
  VERSION=1
end