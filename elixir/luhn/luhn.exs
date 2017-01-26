defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) when is_binary(number) do
    number |> digitize |> checksum
  end

  def checksum(digits) when is_list(digits) do
    digits
    |> Enum.reverse
    |> Enum.with_index
    |> Enum.map(fn({val, idx}) ->
      if (idx |> rem(2) == 0), do: val, else: (val |> luhn_double)
    end)
    |> Enum.sum
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
  def create(number) when is_binary(number) do
    number |> digitize |> create
  end

  def create(digits) when is_list(digits) do
    digits
    |> append( digits |> compute_validation_digit )
    |> Enum.map(&Integer.to_string/1)
    |> Enum.join("")
  end

  defp luhn_double(val) do
    doubled = val * 2
    if doubled > 9, do: doubled - 9, else: doubled
  end

  defp digitize(s) do
    s |> String.replace(~r|\D|, "") |> String.codepoints |> Enum.map(&String.to_integer/1)
  end

  defp compute_validation_digit(digits) do
    digits
    |> append(0)
    |> checksum
    |> luhn_checksum_digit
  end

  defp append(digits, digit) when is_list(digits) do
    digits ++ [digit]
  end

  defp luhn_checksum_digit(number) do
    digit = ( number |> Integer.digits |> Enum.at(-1))
    if digit == 0, do: digit, else: 10 - digit
  end
end
