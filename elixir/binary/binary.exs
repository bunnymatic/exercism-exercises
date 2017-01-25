defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    case (string |> _to_decimal) do
      {:ok, result} ->
        result
      {:error, _} ->
        0
      _ ->
        0
    end
  end

  defp _to_decimal(string) do
    if ~r|^[01]+$| |> Regex.run(string) do
      { :ok,
        string
        |> String.codepoints
        |> Enum.reverse
        |> Enum.reduce({0,0}, fn(bit, {index,acc}) ->
          {
            index+1,
            acc + (bit |> String.to_integer) * :math.pow(2, index)
          }
        end)
        |> elem(1)
      }
    else
      { :error, string }
    end
  end
end
