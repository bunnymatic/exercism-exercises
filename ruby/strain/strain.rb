class Array

  def keep(&block)
    [].tap do |result|
      self.each do |val|
        result << val if (block.call(val))
      end
    end
  end

  def discard(&block)
    keep { |val| !block.call(val) }
  end


end
