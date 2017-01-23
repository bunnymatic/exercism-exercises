class Array
  def accumulate(&block)
    result = []
    self.each do |value|
      result << block.call(value)
    end
    result
  end
end

module BookKeeping
  VERSION =1
end