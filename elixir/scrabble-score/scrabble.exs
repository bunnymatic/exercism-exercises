defmodule Scrabble do

  defp score_map do
    %{
    1 => [?A, ?E, ?I, ?O, ?U, ?L, ?N, ?R, ?S, ?T],
    2 => [?D, ?G],
    3 => [?B, ?C, ?M, ?P],
    4 => [?F, ?H, ?V, ?W, ?Y],
    5 => [?K],
    8 => [?J, ?X],
    10 => [?Q, ?Z]
    }
  end

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> cleanse
    |> String.codepoints()
    |> tally


  end

  defp tally(chars) do
    chars |>
      Enum.map( fn(char) ->
        score_map
        |> Enum.filter( fn({score,letters}) -> String.contains?(to_string(letters), char) end )
        |> Enum.map( fn({score, _}) -> score end )
      end) |>
      List.flatten |>
      Enum.reduce(0, &(&1 + &2))
  end

  defp cleanse(word) do
    word |> String.strip |> String.upcase
  end

end