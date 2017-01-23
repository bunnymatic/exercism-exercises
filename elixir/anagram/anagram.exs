defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    base_downcase = base |> String.downcase
    base_matcher = base |> arrange_letters
    candidates
    |> Enum.filter( fn(candidate) ->
      (String.downcase(candidate) !== base_downcase) and
      (candidate |> arrange_letters) === base_matcher
    end)
  end

  defp arrange_letters(word) do
    word
    |> String.downcase
    |> String.split("", trim: true)
    |> Enum.sort
  end

end