defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> custom_splitter
    |> Enum.map( &upcase_first_letter(&1) )
    |> Enum.join
  end

  defp upcase_first_letter(word) do
    word
    |> String.codepoints
    |> hd
    |> String.upcase
  end

  defp custom_splitter(word) do
    word
    |> String.split(~r|[-\s+]|)
    |> Enum.map( fn(word) -> String.split(word, ~r|(?<=[a-z])(?=[A-Z])|) end)
    |> List.flatten
  end
end