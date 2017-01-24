defmodule Histogram do
  def histogram(string) when is_bitstring(string) do
    string |> String.codepoints |> histogram
  end

  def histogram(chars) when is_list(chars) do
    chars |> Enum.reduce(%{}, fn(letter, memo) ->
      Map.put(memo, letter, Map.get(memo, letter, 0) + 1)
    end)
  end
end

defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers) when is_list(texts) do
    texts
    |> Enum.join
    |> String.downcase
    |> String.replace(~r|[\d\p{P}\p{S}\s]|, "")
    |> String.codepoints
    |> frequency

    receive do
      {:result, result} ->
        IO.puts("received #{inspect(result)}")
        result
    end
  end

  def frequency(chars) do
    x = chars
    |> async_histogram
    IO.inspect(x)
    x
  end

  def async_histogram(text) do
    caller = self()
    spawn(fn ->
      result = text |> Histogram.histogram
      send(caller,{:result, result})
    end)
  end

end
