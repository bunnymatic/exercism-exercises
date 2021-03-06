class Year
  def self.divisible_by?(year, n)
    (year % n) == 0
  end

  def self.leap?(year)
    (divisible_by? year, 4) &&
      !(divisible_by? year, 100) ||
      (divisible_by? year, 400)
  end
end