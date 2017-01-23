defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> Enum.reverse
    |> Enum.reduce([], &_flatten/2)
  end

  defp _flatten([ [h|t] | tail ], acc) do
    flatten([h,t]) ++ _flatten(tail, acc)
  end

  defp _flatten([ nil | t ], acc), do: _flatten(t, acc)
  defp _flatten([ h | t ], acc), do: [ h | _flatten(t, acc) ]
  defp _flatten([], acc), do: acc
  defp _flatten(nil, acc), do: acc
  defp _flatten(v, acc), do: [ v | acc ]
end