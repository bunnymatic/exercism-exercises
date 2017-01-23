class RunLengthEncoding

  def self.encode(s)
    s.scan(/(.)(\1*)/).map do |(char, repeats)|
      [(repeats.length > 0 ? (1 + repeats.length) : "").to_s, char]
    end.flatten.join
  end

  def self.decode(s)
    s.scan(/(\d+)(\D)|(\D)/).map do |(count, char, single)|
      if !single
        char.to_s * count.to_i
      else
        single
      end
    end.join
  end

end

module BookKeeping
  VERSION = 2
end`