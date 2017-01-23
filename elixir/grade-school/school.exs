defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    db
    |> Map.get_and_update(grade, fn(current) ->
      { current, add_uniquely_to_list(current, name) }
    end)
    |> elem(1)
  end

  defp add_uniquely_to_list(current, name) do
    [current] ++ [name] |> List.flatten |> Enum.uniq |> Enum.filter( fn(x) -> x end )
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    db |>
    Map.get(grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    db
    |> Map.keys
    |> Enum.sort
    |> Enum.map(fn(key) ->
      { key, (db |> Map.get(key) |> Enum.sort) }
    end)
  end
end