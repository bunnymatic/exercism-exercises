defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    (1..num)
    |> Enum.map(&row/1)
  end

  defp row(power) when power == 1, do: [1]
  defp row(power) do
    binomial_coefficients(power-1)
  end

  defp binomial_coefficients(power) do
    {_, coefficients} = (1..power)
    |> Enum.reduce({1, []}, fn(cc, {acc, result}) ->
      { acc * (power - cc + 1) / cc, result ++ [ round(acc) ] }
    end)
    (coefficients ++ [1])
  end
end
