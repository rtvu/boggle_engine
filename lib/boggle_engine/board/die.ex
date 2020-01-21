defmodule BoggleEngine.Board.Die do
  @moduledoc false

  # Die is specified by a list of graphemes. Each capital letter signals a
  # different face of the die. Die is represented by a 6 element string list.

  # Converts a specification to a die.
  def make_die(specification) do
    make_die(specification, [])
  end

  defp make_die(specification, result)

  defp make_die([], result) do
    result
  end

  defp make_die([head], result) do
    [head | result]
  end

  defp make_die([first, second | rest], result) do
    # A die face will either have a single capital grapheme or a capital
    # grapheme followed by a lowercase grapheme.
    if uppercase?(second) do
      make_die([second | rest], [first | result])
    else
      make_die(rest, [first <> second | result])
    end
  end

  # Determines if letter is uppercase.
  defp uppercase?(letter) do
    letter == String.upcase(letter)
  end
end
