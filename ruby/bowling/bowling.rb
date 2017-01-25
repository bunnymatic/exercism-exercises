# coding: utf-8
require 'byebug'
class Game

  class BowlingError < StandardError; end

  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  # def frames
  #   [].tap do |frames|
  #     index = 0
  #     loop do
  #       break unless index < @rolls.length
  #       if @rolls[index] == 10
  #         frames << [@rolls[index]]
  #         index += 1
  #       else
  #         frames << [@rolls[index], @rolls[index+1]]
  #         index += 2
  #       end
  #     end
  #   end
  # end

  def validate_rolls
    raise BowlingError.new("Can't have negative pins") if @rolls.any?{|pins| pins.nil? || !pins.between?(0,10)}
  end

  def score
    validate_rolls
    score = 0
    frame_scores = []
    index = 0
    (1..10).each do |frame|
      raise BowlingError.new("Not enought") if @rolls.length < index

      if is_a_strike?(index)
        # strike
        score += process_strike(index, frame)
        frame_scores << score
        index += (frame == 10 ? 3 : 1)
      elsif is_a_spare?(index)
        #spare
        score += process_spare(index, frame)
        frame_scores << score
        index += (frame == 10 ? 3 : 2)
      else
        score += process_frame(index, frame)
        frame_scores << score
        index += 2
      end
    end
    raise BowlingError.new("Too many rolls") if @rolls.length > index
    score
  end

  private
  def is_a_strike?(roll)
    @rolls[roll] == 10
  end
  def is_a_spare?(roll)
    raise BowlingError.new("not enough rolls") unless roll + 1 < @rolls.length
    @rolls[roll] + @rolls[roll+1] == 10
  end

  def process_strike(index, frame)
    next_rolls = [@rolls[index+1],@rolls[index+2]]
    if frame == 10
      raise BowlingError.new("Need to fill out the last frame") if next_rolls.any?(&:nil?)
      raise BowlingError.new("Invalid score for final frames") if next_rolls.first < 10 && next_rolls.inject(:+) > 10
    end
    10 + next_rolls.inject(:+)
  end

  def process_spare(index, frame)
    raise BowlingError.new("Need to fill out the last frame") if frame == 10 && @rolls[index+2].nil?
    10 + @rolls[index+2]
  end

  def process_frame(index, frame)
    scores = [@rolls[index],@rolls[index+1]]
    raise BowlingError.new("Invalid") if scores.any?(&:nil?)
    score = scores.inject(:+)
    raise BowlingError.new("Invalid frame") if !score.between?(0,10)
    score
  end

end

module BookKeeping
  VERSION = 3
end
