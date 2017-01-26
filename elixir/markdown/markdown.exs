defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(m) do
    m
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join
    |> wrap_lists
  end

  defp process(t) do
    preprocessed = t |> process_strong_and_emphasis
    if preprocessed |> is_list_or_header do
      preprocessed |> process_header |> process_list
    else
      preprocessed |> process_text
    end
  end

  defp is_list_or_header(s), do: s |> String.match?(~r|^[\*\#]|)

  defp process_text(t), do: t |> content_tag("p")

  defp process_header(t) do
    cond do
      t |> String.starts_with?("#") ->
        t
        |> parse_header_md_level
        |> enclose_with_header_tag
      true ->
        t
    end
  end

  defp process_list(l) do
    cond do
      l |> String.starts_with?("*") ->
        l
        |> String.trim_leading("* ")
        |> content_tag("li")
      true ->
        l
    end
  end

  defp process_strong_and_emphasis(line) do
    line
    |> String.replace(~r|__([^_]+)__|, "\\1" |> content_tag("strong"))
    |> String.replace(~r|\_([^_]+)\_|, "\\1" |> content_tag("em"))
  end

  defp content_tag(s, tag_name), do: "<#{tag_name}>#{s}</#{tag_name}>"

  defp parse_header_md_level(hwt) do
    [h | t] = hwt |> String.split
    {
      h |> String.length |> header_level,
      t |> Enum.join(" ")
    }
  end

  defp header_level(num), do: "h#{num}"

  defp enclose_with_header_tag({hl, htl}), do: htl |> content_tag(hl)

  defp wrap_lists(l), do: l |> String.replace(~r|(\<li\>.*\<\/li\>)|, "\\1" |> content_tag("ul"))

  # defp inspector(v,s \\"") do
  #   IO.puts("[#{s}] #{inspect(v)}")
  #   v
  # end


end
