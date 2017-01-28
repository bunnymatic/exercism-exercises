defmodule Roman do
  @roman_with_decimal_value [ { "M", 1000 },
                              { "CM", 900 },
                              { "D", 500 },
                              { "CD", 400 },
                              { "C", 100 },
                              { "XC", 90 },
                              { "L", 50 },
                              { "XL", 40 },
                              { "X", 10 },
                              { "IX", 9 },
                              { "V", 5 },
                              { "IV", 4 },
                              { "I", 1 } ]
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number), do: number |> numerals(@roman_with_decimal_value, "")
  def numerals(_, [], acc), do: acc
  def numerals(number, [{_, current_decimal} | rest], acc) when current_decimal > number do
    number |> numerals(rest, acc)
  end
  def numerals(number, [cur | rest], acc) do
    { current_roman, current_decimal } = cur
    number - current_decimal
    |> numerals([cur | rest], acc <> current_roman)
  end
end
