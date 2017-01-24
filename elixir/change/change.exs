defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    cond do
      (values |> length) == 0 ->
        :error
      Enum.min(values) > amount ->
        :error
      true ->
        coin_map = coin_map(values)
        { status, change } = compute_change(amount, values, coin_map)
        case status do
          :ok ->
            { status, change }
          :error ->
            compute_change(amount, values |> shift , coin_map)
        end
    end
  end

  defp shift(list), do: list |> Enum.reverse |> tl |> Enum.reverse

  defp coin_map(values) do
    coin_map =
      values
      |> Enum.reduce(%{}, fn(coin, memo) -> memo |> Map.put(coin, 0) end)
  end

  defp compute_change(amount, available_coins, coin_map) do
    coins_used = available_coins
    |> Enum.sort
    |> Enum.reverse
    |> Enum.reduce({ amount, [] }, &extract_change/2)
    |> elem(1)

    if amount == Enum.sum(coins_used) do
      {
        :ok,
        coins_used |> histogram(coin_map)
      }
    else
      {:error, amount}
    end
  end

  defp histogram(array, acc) do
    array |> Enum.reduce(acc, fn(val, memo) ->
      Map.put(memo, val, Map.get(memo, val, 0) + 1)
    end)
  end

  defp extract_change( coin_value, { amount, coin_counter }) when amount >= coin_value do
    amount = amount - coin_value
    coin_counter = [coin_value | coin_counter ]
    extract_change(coin_value, {amount, coin_counter})
  end

  defp extract_change( _, { amount, coin_counter }) do
    {amount, coin_counter}
  end

end
