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

    def to_s
      (!valid? ? "INVALID:" : "") + @frames.map{|f| f.to_s}.join(" ")
    end

  end

  class Frame

    attr_reader :rolls
    attr_reader :frame

    def initialize(frame, *args)
      @frame = frame
      @rolls = [args].flatten
    end

    def valid?
      return false if @rolls.map(&:to_i).any?{|roll| !roll.between?(0,10)}
      if is_last?
        is_last_frame_valid?
      else
        is_strike? || (total <= 10 && !second.nil?)
      end
    end

    def to_s
      s = valid? ? "" : "N/A"
      if !is_last?
        s += "#{@frame}:[%s,%s]" % [ first, second.inspect ]
        return "X#{s}" if is_strike?
        return "/#{s}" if is_spare?
      else
        s += "10:#{rolls.inspect}"
      end
      s
    end

    def is_last?
      frame == 10
    end

    def is_strike?
      first == 10
    end

    def is_spare?
      (first + second.to_i) == 10
    end

    def total
      is_last? ? rolls.inject(:+) : (first + second.to_i)
    end

    private
    def first
      rolls[0]
    end

    def second
      rolls[1]
    end

    def bonus
      rolls[2]
    end

    def is_last_frame_valid?
      (is_strike? && includes_strike_bonus_rolls?) ||
        (is_spare? && includes_bonus_rolls?) ||
        (!is_spare? && !is_strike? && has_only_2_rolls?)
    end

    def has_only_2_rolls?
      !second.nil? && bonus.nil?
    end

    def includes_bonus_rolls?
      !second.nil? && !bonus.nil?
    end

    def includes_strike_bonus_rolls?
      includes_bonus_rolls? && ((second.to_i == 10) || (second.to_i + bonus.to_i) <= 10)
    end

  end

  def initialize
    @rolls = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    raise BowlingError.new("No frames to score") if @rolls.empty?
    @frames = Frames.new(@rolls)
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

end

module BookKeeping
  VERSION = 3
end
