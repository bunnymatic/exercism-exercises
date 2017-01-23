defmodule Roman do
  @roman_numerals ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
  @decimal_values [ 1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    numerals(number, @decimal_values, @roman_numerals, "")
  end
  def numerals(_, [], [], acc), do: acc
  def numerals(number, [cur | rest], [_ | roman], acc) when cur > number do
    numerals(number, rest, roman, acc)
  end
  def numerals(number, [cur | rest], [cur_roman | roman], acc) do
    v = number - cur
    numerals(v, [cur | rest], [cur_roman | roman], acc <> cur_roman)
  end
end