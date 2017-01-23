class Complement

  LUT = {
    "C" => "G",
    "G" => "C",
    "T" => "A",
    "A" => "U"
  }

  def self.of_dna(amino_acids)
    transformed = amino_acids.split("").map{|amino_acid| LUT[amino_acid]}
    return "" if !transformed.all?
    transformed.join
  end

  class << self
    private
    def translate_amino_acid(amino_acid)
      LUT[amino_acid]
    end
  end

end

module BookKeeping
  VERSION = 4 # Where the version number matches the one in the test.
end