defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn( {score, letters}, acc) ->
      letters
      |> Enum.reduce(%{}, fn(letter, acc2) ->
        acc2 |> Map.put(letter |> String.downcase, score)
      end)
      |> Map.merge(acc)
    end)
  end
end