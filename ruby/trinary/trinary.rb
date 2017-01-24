require 'byebug'
class Trinary

  def initialize(val)
    @value = val
  end

  def valid?
    @value.gsub(/\s+/,'') =~ /^[012]+$/
  end

  def to_decimal
    return 0 unless valid?
    @value.chars.reverse.each.with_index.inject(0) do |acc,(bit, index)|
      acc += bit.to_i * (3 ** index)
      acc
    end
  end

end

module BookKeeping
  VERSION = 1
end
