defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split(~r/\n/)
    |> Enum.map( fn(row) ->
      row
      |> String.split(~r/\s+/)
      |> Enum.map( fn(number) ->
        number |> String.to_integer
      end)
    end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str |> rows |> transpose
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    row_candidates = str
    |> rows
    |> candidates_by_row
    col_candidates = str
    |> columns
    |> candidates_by_column
    row_candidates |> intersect_with(col_candidates)
  end

  defp intersect_with(list1, list2) do
    tmp = list1 -- list2
    list1 -- tmp
  end

  defp candidates_by_row(matrix_rows) do
    matrix_rows
    |> Enum.with_index
    |> Enum.map(fn({row, row_index}) ->
      row
      |> matches( row |> Enum.max )
      |> Enum.map(&({row_index, &1}))
    end)
    |> List.flatten
  end

  defp candidates_by_column(matrix_cols) do
    matrix_cols
    |> Enum.with_index
    |> Enum.map(fn({col, col_index}) ->
      col
      |> matches( col |> Enum.min )
      |> Enum.map(&({&1, col_index}))
    end)
    |> List.flatten
  end

  @spec transpose([[integer]]) :: [[integer]]
  defp transpose([[]|_]), do: []
  defp transpose(matrix) do
    [ matrix |> Enum.map(&hd/1) | transpose( matrix |> Enum.map(&tl/1) ) ]
  end

  defp matches(list, element) do
    list
    |> Enum.with_index
    |> Enum.filter_map(fn {x, _} -> x == element end, fn {_, i} -> i end)
  end

end
