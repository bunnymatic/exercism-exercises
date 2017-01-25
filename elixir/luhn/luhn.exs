defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    [h| doubled] = ("0" <> number)
    |> cleaned
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
    |> luhn_double
    IO.inspect(doubled)
    doubled |> Enum.sum
  end

  defp luhn_double(digits) do
    digits
    |> Enum.with_index()
    |> Enum.map( fn({idx, val}) ->
      cond do
        (idx |> rem(2)) == 1 ->
          val = val * 2
          if val >= 10, do: val - 9, else: val
        true ->
          val
      end
    end)
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    (number |> checksum) |> rem(10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    [h| doubled] = ("0" <> number)
    |> cleaned
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
    |> Enum.map_every(2, &(&1 * 2))
    |> Enum.map(fn(digit) ->
      if digit < 10, do: digit, else: digit - 9
    end)
    IO.inspect(doubled)
    checksum_prefix = 10 * (number |> cleaned |> String.to_integer)
    checksum_digit = doubled
    |> Enum.sum
    |> get_ones_digit
    |> subtract_from(10)

    (checksum_prefix + checksum_digit) |> Integer.to_string
  end

  defp cleaned(s), do: s |> String.replace(~r|\s+|, "")

  defp times(num, factor) do
    num * factor
  end

  defp get_ones_digit(num) do
    [h|rest] = num |> Integer.to_string |> String.codepoints |> Enum.reverse
    h |> String.to_integer
  end

  defp subtract_from(num, base) do
    if num > 0, do: base - num, else: 0
  end
end

cardnum = "046 454 28"
IO.puts(cardnum)
IO.puts("create")
IO.inspect(Luhn.create(cardnum))
IO.puts("checksum")
IO.inspect(Luhn.checksum(cardnum <> "0"))


IO.puts("create")
cardnum = "123"
IO.puts(cardnum)
IO.inspect(Luhn.create(cardnum))
IO.puts("checksum")
IO.inspect(Luhn.checksum(cardnum <> "0"))
