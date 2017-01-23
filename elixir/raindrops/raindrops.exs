defmodule Raindrops do

  defmacro is_divisible_by(val, divisor) do
    quote do: rem(unquote(val), unquote(divisor)) == 0
  end

  @factors %{ 3 => "Pling", 5 => "Plang", 7 => "Plong" }

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    result = [3,5,7]
    |> Enum.map( fn(factor) ->
      if is_divisible_by(number, factor) do
        (@factors |> Map.get(factor))
      end
    end)
    |> Enum.join
    if String.trim(result) == "", do: Integer.to_string(number), else: result
  end

end