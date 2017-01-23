defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.replace(~r|[^\{\(\[\]\)\}]|, "")
    |> String.codepoints
    |> balanced?
  end

  @starters "{([" |> String.codepoints
  @closers "])}" |> String.codepoints
  @bracket_pairs [ "{}", "[]", "()" ]

  def balanced?(brackets), do: balanced?(brackets, [])
  def balanced?([], []), do: true
  def balanced?([], _), do: false

  def balanced?([c|rest], stack) when c in @starters do
    balanced?(rest, [c | stack])
  end

  def balanced?(["}"|rest], ["{"|stack]) do
    balanced?(rest, stack)
  end

  def balanced?(["]"|rest], ["["|stack]) do
    balanced?(rest, stack)
  end

  def balanced?([")"|rest], ["("|stack]) do
    balanced?(rest, stack)
  end

  def balanced?([c|_],_) when c in @closers, do: false

end