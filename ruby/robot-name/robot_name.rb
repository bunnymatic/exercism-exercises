require 'set'

class DuplicateNameError < StandardError; end

class RobotNameService

  LETTERS = ('A'..'Z').to_a.freeze
  DIGITS = ('0'..'9').to_a.freeze

  MAX_NUM_TRIES = 5

  @@names = Set.new()

  @@random = Random.new

  def self.generate_name
    new_name = nil
    MAX_NUM_TRIES.times.each do
      new_name = random_name
      break unless @@names.include? new_name
    end
    if !@@names.add?(new_name)
      raise DuplicateNameError.new("We were unable to find an unused name in #{MAX_NUM_TRIES} tries.")
    end
    new_name
  end

  class << self
    private
    def random_name
      (LETTERS.sample(2) + DIGITS.sample(3)).join
    end

    def choose_letters(count)
      count.times.map { choose_letter }.join
    end

    def choose_digits(count)
      count.times.map { choose_digit }.join
    end

    def choose_letter
      _choose_randomly_from_list(LETTERS)
    end

    def choose_digit
      _choose_randomly_from_list(DIGITS)
    end

    def _choose_randomly_from_list(list)
      list[@@random.rand(0..list.length)]
    end
  end
end

class Robot

  attr_reader :name

  def initialize
    @name = RobotNameService.generate_name
  end

  def reset
    @name = RobotNameService.generate_name
  end

end

module BookKeeping
  VERSION = 2
end