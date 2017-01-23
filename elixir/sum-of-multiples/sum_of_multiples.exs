defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    Range.new(1, limit - 1)
    |> Enum.reduce(0, fn(val, memo) ->
      if is_a_multiple?(val, factors), do: memo+val, else: memo
    end)
  end

  defp is_a_multiple?(val, factors) do
    factors
    |> Enum.map(fn(f) -> (rem(val, f) == 0) end)
    |> Enum.any?(&(&1))
  end
end