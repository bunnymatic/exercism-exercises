class PhoneNumber

  attr_reader :number

  INVALID_NUMBER = "0000000000"

  def initialize(phone_number_string)
    @number = validate(sanitize(phone_number_string))
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(%s) %s-%s" % [ number[0..2], number[3..5], number[6..-1] ]
  end

  private

  def sanitize(s)
    s.gsub(/[[[:punct:]]\s]+/, '')
  end

  def validate(number)
    (/^1?\d{10}$/ =~ number) ? number[-10..-1] : INVALID_NUMBER
  end

end