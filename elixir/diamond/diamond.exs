defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    top_rows = rows(letter)
    top_rows ++ (top_rows |> reverse_and_slice)
    |> Enum.join
  end

  defp reverse_and_slice(str) when is_binary(str), do: str |> String.reverse |> String.slice(1..-1)
  defp reverse_and_slice(list), do: list |> Enum.reverse |> Enum.slice(1..-1)

  defp rows(letter) do
    letters = (?A..letter) |> Enum.map(fn(ltr) -> [ltr] |> to_string end)
    width = (letters |> length)
    letters
    |> Enum.with_index
    |> Enum.map( fn( {ltr, idx} ) ->
      (ltr |> row(width, idx)) <> "\n"
    end)
  end

  defp row(letter, 1, _), do: [letter] |> to_string
  defp row(letter, width, idx) do
    lhs = (whitespace(width - idx - 1) <> letter <> whitespace(idx))
    lhs <> (lhs |> reverse_and_slice)
  end

  defp whitespace(len) when len == 0, do: ""
  defp whitespace(len) do
    (0..len-1) |> Enum.map(fn(_) -> " " end) |> Enum.join
  end

  # defp inspector(v,s), do: (IO.puts("[#{s}] #{inspect(v)}"); v)
  # defp inspector(v), do: (IO.puts("[check] #{inspect(v)}"); v)

end
