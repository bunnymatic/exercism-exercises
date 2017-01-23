require 'byebug'
class Integer
  def to_roman
    RomanNumerals.convert(self)
  end
end

class RomanNumerals
  DECIMAL_VALUES = [ 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1 ]
  ROMAN_NUMERALS = %w| M CM D CD C XC L XL X IX V IV I |

  def self.convert(value)
    roman = ""
    DECIMAL_VALUES.each_with_index do |decValue, index|
      loop do
        break if decValue > value
        value -= decValue
        roman << ROMAN_NUMERALS[index]
      end
    end
    roman
  end
end

module BookKeeping
  VERSION = 2
end