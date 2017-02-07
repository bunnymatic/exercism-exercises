defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decim2al("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(String.t()) :: integer
  def to_decimal(hex) do
    digit_response = hex |> digits_to_numbers

    case digit_response do
      {:ok, d} ->
        case _to_decimal(d, 16) do
          {:ok ,val} ->
            val
          _ ->
            0
        end
      _ ->
        0
    end
  end

  # defp inspector(v,s), do: (IO.puts("[#{s}] #{inspect(v)}"); v)
  # defp inspector(v), do: (IO.puts("[check] #{inspect(v)}"); v)

  def digits_to_numbers(digit_string) do
    numbers = digit_string
    |> String.downcase
    |> String.codepoints
    |> Enum.map(&digit_to_number/1)

    status = case (numbers |> Enum.all?(fn(x) -> (x |> elem(0)) === :ok end)) do
               true ->
                 :ok
               false ->
                 :error
             end
    { status, numbers |> Enum.map(fn(x) -> x |> elem(1) end) }
  end

  def digit_to_number(digit) do
    number = %{ "a" => 10, "b" => 11, "c" => 12, "d" => 13, "e" => 14, "f" => 15 } |> Map.get(digit)
    case number do
      nil ->
        try do
          { :ok, digit |> String.to_integer }
        rescue
          e in ArgumentError ->
            { :error, "invalid digit #{digit}" }
        end
      _ ->
        { :ok, number }
    end
  end

  def _to_decimal(digits, base) do
    { :ok,
      digits
      |> Enum.reverse
      |> Enum.reduce({0,0}, fn(digit, {index,acc}) ->
        {
          index+1,
          acc + digit * :math.pow(base, index)
        }
      end)
      |> elem(1)
    }
  end
end
