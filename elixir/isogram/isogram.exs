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

defmodule Isogram do
  import Histogram

  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence |> cleanse |> histogram |> Enum.all?(fn({_,v}) -> v === 1 end)
  end

  defp cleanse(sentence) do
    sentence |> String.replace(~r|[\s\-]|, "")
  end

end