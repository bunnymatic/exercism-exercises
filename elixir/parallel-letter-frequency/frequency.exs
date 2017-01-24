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
  def frequency(texts, workers) when length(texts) == 0 do
    IO.puts("EMPTY FREQ")
    %{}
  end

  def frequency(texts, workers) when is_list(texts) and is_number(workers) do
    :observer.start
    caller = self()
    numchars = texts |> List.flatten |> Enum.join |> String.length
    chunk_size = Enum.min([numchars, round(numchars/workers)])
    IO.puts("[#{inspect(self())}] CALLING MAIN FREQ for #{workers} workers and #{numchars} characters : #{chunk_size} chars per chunk")
    pids = texts
    |> Enum.join
    |> String.downcase
    |> String.replace(~r|[\d\p{P}\p{S}\s]|, "")
    |> String.codepoints
    |> Enum.chunk(chunk_size)
    |> Enum.map(fn(chunk) ->
      chunk |> frequency(caller)
    end)

    # listen()
    # Process.exit(self())

  end

  def frequency(chars, caller) do
    IO.puts("CHARS #{inspect(chars)}")
    x = chars
    |> async_histogram(caller)
    IO.inspect(x)
    x
  end

  def listen do
    receive do
      {:result, result} ->
        IO.puts("[#{inspect(self())}] received #{inspect(result)}")
        result
      x ->
        IO.puts("Received unknown #{inspect(x)}")
    end
    listen()
  end

  def async_histogram(text, caller) do
    spawn_link(fn ->
      IO.puts("[#{inspect(self())}] Calling hist #{inspect(text)}")
      result = text |> Histogram.histogram
      IO.inspect(result)
      send(caller,{:result, result})
    end)
  end

end
