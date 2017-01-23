defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when strand1 == strand2 do
    {:ok, 0}
  end

  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2) do
    {:error, "Lists must be the same length"}
  end

  def hamming_distance(strand1, strand2) do
    dist = List.zip([strand1, strand2])
    |> Enum.reduce( 0, fn(pair, acc) ->
      acc + distance(pair)
    end)
    {:ok, dist}
  end

  defp distance({a,b}) when a === b, do: 0
  defp distance(_), do: 1

end