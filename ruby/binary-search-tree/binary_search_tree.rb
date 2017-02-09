require 'byebug'

class Bst

  attr_reader :data, :left, :right

  def initialize(val)
    @data = val
    @left = nil
    @right = nil
  end

  def insert(val)
    val <= @data ? insert_left(val) : insert_right(val)
  end

  def each(&block)
    fetch.each &block
  end

  protected
  def fetch(result = [])
    if @left
      @left.fetch(result)
    end
    result << @data
    if @right
      @right.fetch(result) if @right
    end
    result
  end

  private
  def insert_left(val)
    if @left
      @left.insert(val)
    else
      @left = Bst.new(val) unless @left
    end
  end

  def insert_right(val)
    if @right
      @right.insert(val)
    else
      @right = Bst.new(val) unless @right
    end
  end

  VERSION = 1
end
