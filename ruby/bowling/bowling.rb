# coding: utf-8
require 'byebug'
class Game

  class BowlingError < StandardError; end

  class Frames
    def initialize(rolls)
      nrolls = rolls.length
      @frames = [].tap do |frames|
        index = 0
        loop do
          break unless index < nrolls
          current_frame = frames.length + 1
          if current_frame < 10
            if rolls[index] == 10
              frames << Frame.new(current_frame, rolls[index])
              index += 1
            else
              frames << Frame.new(current_frame, rolls[index], rolls[index+1])
              index += 2
            end
          else
            frames << Frame.new(current_frame, rolls[index..-1])
            index += 3
          end
        end
      end
    end

    def valid?
      @frames.all?{|f| f.valid?} && @frames.length == 10
    end

    def get(frame)
      @frames[frame-1]
    end

    def next_rolls(current_frame)
      @frames[(current_frame)..(current_frame+1)].map(&:rolls).flatten.compact.first(2)
    end

    def private
      def select(first, last)

      end
    end
  end

  class Frame

    attr_reader :rolls
    attr_reader :frame

    def initialize(frame, *args)
      @frame = frame
      @rolls = [args].flatten
    end

    def first
      rolls[0]
    end
    def second
      rolls[1]
    end
    def bonus
      rolls[2]
    end

    def is_last?
      frame == 10
    end

    def total
      is_last? ? rolls.inject(:+) : (first + second.to_i)
    end

    def valid?
      if is_last?
        !second.nil? &&
          (
            (is_strike? && !bonus.nil?) ||
            (is_spare? && !bonus.nil?) ||
            ((second < 10) && (second.to_i + bonus.to_i <= 10))
          )
      else
        is_strike? || (total <= 10 && !second.nil?)
      end
    end

    def is_strike?
      first == 10
    end
    def is_spare?
      total == 10
    end
    def to_s
      return "N/A" if !valid?
      if !is_last?
        s = "#{@frame}:[%s,%s]" % [ first, second.inspect ]
        return "X#{s}" if is_strike?
        return "/#{s}" if is_spare?
      else
        s = "10:#{rolls.inspect}"
      end
      s
    end
  end

  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
    @frames = process_rolls
  end

  def score
    raise BowlingError.new("No frames to score") if @frames.nil?
    raise BowlingError.new("There are invalid frames") unless @frames.valid?
    (1..10).inject(0) do |total, frame_number|
      total += compute_score(frame_number)
    end
  end

  private
  def compute_score(frame_number)
    current_frame = @frames.get(frame_number)
    if current_frame.is_last?
      current_frame.total
    elsif current_frame.is_strike? || current_frame.is_spare?
      current_frame.total + compute_bonus(frame_number)
    else
      current_frame.total
    end
  end

  def compute_bonus(frame_number)
    current_frame = @frames.get(frame_number)
    next_rolls = @frames.next_rolls(frame_number)
    if current_frame.is_strike?
      next_rolls.map(&:to_i).inject(:+)
    else
      next_rolls.first.to_i
    end

  end

  def process_rolls
    Frames.new(@rolls)
  end

end

module BookKeeping
  VERSION = 3
end
