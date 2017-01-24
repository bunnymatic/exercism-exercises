require 'byebug'
class Game

  class BowlingError < StandardError; end

  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def validate_rolls
    raise BowlingError.new("Can't have negative pins") if @rolls.any?{|pins| pins.nil? || !pins.between?(0,10)}

  end

  def score
    validate_rolls
    frame = 1
    index = 0
    score = 0
    expected_number_of_rolls = 0
    loop do
      break if frame > 10 || index >= @rolls.length
      if @rolls[index] == 10
        # strike
        score += process_strike(index, frame)
        index += 1
      elsif @rolls[index] + @rolls[index+1] == 10
        #spare
        score += process_spare(index, frame)
        index += 2
      else
        score += process_frame(index, frame)
        index += 2
      end
      frame += 1
    end
    raise BowlingError.new("Too many frames") if !@rolls[index+2].nil?
    raise BowlingError.new("Incomplete game") if frame != 11
    score
  end

  private
  def process_strike(index, frame)
    next_rolls = [@rolls[index+1],@rolls[index+2]]
    if frame == 10
      raise BowlingError.new("Need to fill out the last frame") if next_rolls.last.nil?
      raise BowlingError.new("Invalid score for final frames") if next_rolls.first < 10 && next_rolls.inject(:+) > 10
    end
    10 + next_rolls.inject(:+)
  end

  def process_spare(index, frame)
    raise BowlingError.new("Need to fill out the last frame") if frame == 10 && @rolls[index+2].nil?
    10 + @rolls[index+2]
  end

  def process_frame(index, frame)
    score = [@rolls[index],@rolls[index+1]].inject(:+)
    raise BowlingError.new("Invalid frame") if !score.between?(0,10)
    score
  end

end

module BookKeeping
  VERSION = 3
end
