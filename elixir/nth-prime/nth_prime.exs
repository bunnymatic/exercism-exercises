defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    case count do
      0 ->
        raise ArgumentError, message: "There is no zeroth prime"
      _ ->
        Stream.interval(1) |> Stream.drop(2) |> Stream.filter(&is_prime/1) |> Enum.take(count) |> Enum.at(-1)
    end
  end

  defp is_prime(x), do: (2..x |> Enum.filter(fn a -> rem(x, a) == 0 end) |> length()) == 1

end