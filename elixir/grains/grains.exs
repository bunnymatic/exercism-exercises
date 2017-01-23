defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number in (1..64) do
    2 |> :math.pow(number - 1) |> round
  end

  def square(_) do
    raise ArgumentError, message: "The requested square must be between 1 and 64 (inclusive)"
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    (1..64) |> Enum.map(&square/1) |> Enum.sum
  end
end
