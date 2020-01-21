defmodule BoggleEngine.Utilities do
  @moduledoc false

  # Takes a list of graphemes and returns a list of strings separated on
  # uppercase.
  def chunk_on_uppercase(graphemes) do
    graphemes
    |> chunk_on_uppercase("", [])
    |> Enum.reverse()
  end

  defp chunk_on_uppercase(graphemes, partial_string, result)

  defp chunk_on_uppercase([], "", result) do
    result
  end

  defp chunk_on_uppercase([], partial_string, result) do
    [partial_string | result]
  end

  defp chunk_on_uppercase([first | rest], "", result) do
    if uppercase?(first) do
      chunk_on_uppercase(rest, first, result)
    else
      chunk_on_uppercase(rest, "", result)
    end
  end

  defp chunk_on_uppercase([first | rest], partial_string, result) do
    if uppercase?(first) do
      chunk_on_uppercase(rest, first, [partial_string | result])
    else
      chunk_on_uppercase(rest, partial_string <> first, result)
    end
  end

  # Determines if letter is uppercase.
  defp uppercase?(letter) do
    letter == String.upcase(letter)
  end
end
