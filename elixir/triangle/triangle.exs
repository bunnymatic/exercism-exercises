defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    [s1 | [s2 | [s3 | _]]] = [a,b,c] |> Enum.sort
    cond do
      has_negative_sides?(s1,s2,s3) ->
        { :error, "all side lengths must be positive" }
      !satisfies_triangle_equality?(s1,s2,s3) ->
        { :error, "side lengths violate triangle inequality" }
      true ->
        _kind(s1,s2,s3)
    end
  end

  defp has_negative_sides?(s1, s2, s3), do: [s1, s2, s3] |> Enum.any?(fn(x) -> x <= 0 end)

  defp satisfies_triangle_equality?(s1, s2, s3), do: s3 < s2 + s1

  defp _kind(s1, s2, s3) when (s1 === s2) and (s1 === s3), do: {:ok, :equilateral}
  defp _kind(s1, s2, s3) when (s1 === s2) or (s2 === s3), do: {:ok, :isosceles}
  defp _kind(_s1, _s2, _s3), do: {:ok, :scalene}

end