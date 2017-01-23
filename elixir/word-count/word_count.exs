defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    cleanse(sentence) |> String.split |> Enum.reduce(%{}, fn(word, memo) ->
      normalized_word = normalize(word)
      Map.put(memo, normalized_word, Map.get(memo, normalized_word, 0) + 1)
    end)
  end

  defp cleanse(sentence) do
    Regex.replace( ~r|\s+|u, Regex.replace( ~r|[\s,!@#\$%\^&\*\(\)_:]|u, sentence, " " ), " ")
  end

  defp normalize(word) do
    String.downcase(word)
  end
end