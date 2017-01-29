defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) when num === 1, do: [[1]]
  def rows(num) do
    previous_row = rows(num-1)
    (2..num)
    |> Enum.reduce(rows(index-1), fn(index, acc) ->
      IO.puts("#{num} #{index} #{inspect(rows(index-1))}")
      acc ++ [ rows(index-1) * (num - index) / (index + 1) ]
    end)
  end
end
