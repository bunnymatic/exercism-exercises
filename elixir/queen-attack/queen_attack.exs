defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0,3}, black \\ {7,3}) do
    if (white == black) do
      raise ArgumentError, message: "You can't start the queens on the same square"
    end
    %Queens{ white: white, black: black }
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    (0..7)
    |> Enum.reduce([], fn(rw, rows) ->
      rows ++ [ queens |> board_column(rw) ]
    end)
    |> Enum.join("\n")
  end

  defp board_column(queens, rw) do
    (0..7)
    |> Enum.reduce("", fn(cl, column_string) ->
      column_string <> (queens |> board_character({rw, cl}))
    end)
    |> String.trim
  end

  defp board_character( queens, pos ) do
    cond do
      queens.white === pos ->
        "W "
      queens.black === pos ->
        "B "
      true ->
        "_ "
    end
  end


  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    (queens |> are_in_same_row?) ||
    (queens |> are_in_same_column?) ||
    (queens |> share_a_diagonal?)
  end

  defp are_in_same_row?(queens), do: (queens.white |> row) === (queens.black |> row)
  defp are_in_same_column?(queens), do: (queens.white |> column) === (queens.black |> column)
  defp share_a_diagonal?(queens) do
    (queens.white |> row_column_difference) === (queens.black |> row_column_difference)
  end

  defp row_column_difference({row, col}), do: (row - col) |> abs
  defp row({r, _}), do: r
  defp column({_, c}), do: c

end
