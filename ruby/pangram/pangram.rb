class Pangram

  NUM_CHARS_IN_ALPHABET = 26

  def self.pangram?(phrase)
    chars = get_characters(phrase)
    chars.length == NUM_CHARS_IN_ALPHABET
  end

  class << self
    private
    def get_characters(phrase)
      phrase.downcase.gsub(/[^[a-z]]/, '').split("").sort.compact.uniq
    end
  end

end

module BookKeeping
  VERSION = 3 # Where the version number matches the one in the test.
end