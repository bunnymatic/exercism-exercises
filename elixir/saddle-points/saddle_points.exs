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
    str
    |> rows
    |> inspector("Matrix")
    |> candidates_by_row
    |> validate_candidates(str)
  end

  defp valid_candidates(candidates, columns) do
    IO.inspect(columns)
    IO.inspect(candidates)
  end

  defp candidates_by_row(matrix_rows) do
    matrix_rows
    |> Enum.with_index
    |> Enum.map(fn({row, col_index}) ->
      { col_index, row |> index_of(row |> Enum.max) }
    end)
  end

  defp validate_candidates(candidates,str) do
    matrix_columns = str |> columns
    candidates
    |> Enum.filter(fn(candidate) ->
      IO.puts("Checking candidate #{inspect(candidate)}")
      { col_index, row_index } = candidate
      matrix_columns
      |> inspector("Cols")
      |> Enum.map(fn(col) ->
        col_index === (col |> index_of(col |> Enum.min))
      end)
      |> inspector("ColCheck")
      |> Enum.any?(&(&1))
    end)
  end

  @spec transpose([[integer]]) :: [[integer]]
  defp transpose([[]|_]), do: []
  defp transpose(matrix) do
    [ matrix |> Enum.map(&hd/1) | transpose( matrix |> Enum.map(&tl/1) ) ]
  end

  defp index_of(list, element) do
    list
    |> Enum.with_index
    |> Enum.filter_map(fn {x, _} -> x == element end, fn {_, i} -> i end)
    |> Enum.at(0)
  end

  def inspector(v,s), do: (IO.puts("[#{s}] #{inspect(v)}"); v)

end
