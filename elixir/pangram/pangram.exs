defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @alphabet ((?a..?z) |> Enum.to_list)

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    sentence
    |> extract_letters
    |> Enum.count == length(@alphabet)
  end

  defp extract_letters(sentence) do
    sentence
    |> String.downcase
    |> String.replace(~r|[^#{@alphabet}]|u, "")
    |> String.split("", trim: true)
    |> Enum.uniq
  end

end