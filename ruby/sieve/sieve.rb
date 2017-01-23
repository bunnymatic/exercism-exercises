require 'byebug'
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

module BookKeeping
  VERSION = 1 # Where the version number matches the one in the test.
end