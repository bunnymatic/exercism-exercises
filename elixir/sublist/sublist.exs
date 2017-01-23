defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b ->
        :equal
      contains?(a,b) ->
        :superlist
      contains?(b,a) ->
        :sublist
      true ->
        :unequal
    end
  end

  defp contains?(master, sub) do
    masterLen = length(master)
    subLen = length(sub)
    cond do
      subLen > masterLen ->
        false
      Enum.take( master, subLen ) === sub ->
        true
      true ->
        [_|t] = master
        contains?(t, sub)
    end
  end
end