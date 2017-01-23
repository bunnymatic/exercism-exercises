class Binary

  def self.to_decimal(bit_string)
    raise ArgumentError.new("String must be valid binary (0's and 1's only)") if !self.is_binary?(bit_string)
    position = 0
    bit_string.reverse.chars.reduce(0) do |acc, bit|
      acc += (1 << position) if bit == "1"
      position += 1
      acc
    end
  end

  def self.is_binary?(bit_string)
    /^[01]+$/ =~ bit_string
  end
end

module BookKeeping
  VERSION = 3
end