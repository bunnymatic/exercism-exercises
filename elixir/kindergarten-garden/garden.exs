defmodule Array2 do


end

defmodule Garden do

  @plants %{
    "R" => :radishes,
    "C" => :clover,
    "G" => :grass,
    "V" => :violets
  }

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names) do
    garden = info_string |> unpack_garden

    student_names
    |> Enum.sort
    |> Enum.reduce({0, %{}}, fn(name, {idx, acc}) ->
      entry = [ garden|> Enum.at(idx) ]
      |> Enum.filter(&(&1))
      |> List.flatten
      |> List.to_tuple
      { idx + 1,
        acc |> Map.put(name, entry)
      }
    end)
    |> elem(1)
  end

  def info(info_string) do
    info(info_string,
      [ :alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet,
        :ileana, :joseph, :kincaid, :larry ]
    )
  end

  defp extract_rows(info_string) do
    info_string |> String.split(~r|\n|u)
  end

  defp translate_plant(plant_character) do
    @plants |> Map.get(plant_character)
  end

  def swap_inner_elements([a|[b|[c|d]]]) do
    [a,c,b|d]
  end

  def unpack_garden(info_string) do
    info_string
    |> extract_rows
    |> Enum.map(fn(plant_characters) -> plant_characters |> String.codepoints end)
    |> List.zip
    |> Enum.chunk(2)
    |> Enum.map(fn(chunk) ->
      chunk
      |> Enum.map(fn(t) -> t |> Tuple.to_list end)
      |> List.flatten
      |> Enum.map(fn(c) -> c |> translate_plant end)
      |> swap_inner_elements
    end)
  end
end