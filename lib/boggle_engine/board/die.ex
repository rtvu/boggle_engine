defmodule BoggleEngine.Board.Die do
  @moduledoc false

  # Die is specified by a list of graphemes. Each capital letter signals a
  # different face of the die. Die is represented by a 6 element string list.

  alias BoggleEngine.Utilities

  # Gets a die from string.
  def from_string(string) do
    Utilities.chunk_string_on_uppercase(string)
  end
end
