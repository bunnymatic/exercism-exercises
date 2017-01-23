defmodule Bob do
  def hey(input) do
    cond do
      empty?(input) ->
        "Fine. Be that way!"
      asking?(input) ->
        "Sure."
      shouting?(input) ->
        "Whoa, chill out!"
      true ->
        "Whatever."
    end
  end

  @spec empty?([char]) :: boolean
  defp empty?(input) do
    String.strip(input) == ""
  end

  @spec shouting?([char]) :: boolean
  defp shouting?(input) do
    s = clean(input)
    if length(s) != 0 do
      clean(input) |> Enum.all?(fn(x) ->
        List.to_string([x]) =~ ~r/^\p{Lu}$/u
      end)
    end
  end

  @spec asking?(String.t) :: boolean
  defp asking?(input) do
    input =~ ~r|\?$|
  end

  @spec clean([char]) :: [char]
  defp clean(input) do
    s = Regex.replace(~r|[0-9\W]|u, input, "")
    String.to_char_list(s)
  end


end