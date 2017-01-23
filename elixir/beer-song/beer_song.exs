defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) when number > 2 do
    current = number - 1
    next = number - 2
    "#{bottles(current)} of beer on the wall, #{bottles(current)} of beer.\nTake one down and pass it around, #{bottles(next)} of beer on the wall.\n"
  end

  def verse(number) when number == 2 do
    "1 bottle of beer on the wall, 1 bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
  end

  def verse(number) when number == 1 do
    "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
  end

  defp bottles(count) when count > 1, do: "#{count} bottles"
  defp bottles(_), do: "1 bottle"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range) do
    range |> Enum.map(&verse/1) |> Enum.join("\n")
  end

  def lyrics() do
    (100..1) |> lyrics
  end

end