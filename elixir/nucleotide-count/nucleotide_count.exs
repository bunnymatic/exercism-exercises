defmodule Histogram do
  def histogram(string) when is_bitstring(string) do
    string |> String.codepoints |> histogram
  end

  def histogram(chars) when is_list(chars) do
    chars |> Enum.reduce(%{}, fn(letter, memo) ->
      Map.put(memo, letter, Map.get(memo, letter, 0) + 1)
    end)
  end
end

defmodule NucleotideCount do

  require Histogram

  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    Map.get(histogram(strand),nucleotide)
  end


  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    counts = strand |> Histogram.histogram
    Enum.reduce(@nucleotides, counts, fn(nuc, memo) ->
      Map.put_new(memo, nuc, 0)
    end )
  end

end