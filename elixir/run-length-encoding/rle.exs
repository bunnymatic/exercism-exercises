defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    tally(String.codepoints(string), [])
    |> Enum.map( fn([count, char]) -> "#{count}#{char}" end)
    |> Enum.join
  end

  defp tally([], result) do
    result
    |> Enum.reverse
    |> Enum.map(fn {char, freq} -> [ freq, char ] end)
  end

  defp tally([head|tail], []) do
    tally(tail, [{head,1}])
  end

  defp tally([head|tail], [{head,n}|tail2]) do
    tally(tail, [{head,n+1}|tail2])
  end

  defp tally([head|tail], result) do
    tally(tail, [{head,1}|result])
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    ~r|(\d+)(\D+)|
    |> Regex.scan(string, capture: :all_but_first)
    |> Enum.map(fn([count, letter]) ->
      String.duplicate(letter, String.to_integer(count))
    end)
    |> Enum.join
  end
end