defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.codepoints
    |> Enum.drop_every(2)
    |> Enum.map( fn(digit) ->
      digit
      |> String.to_integer
      |> (fn(v) -> v*2 end).()
    end)
    |> Enum.reduce(0, fn(v,acc) -> acc + v end)
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
  end
end
