defmodule BoggleEngine.Board.Die do
  @moduledoc false

  # Die is specified by a list of graphemes. Each capital letter signals a
  # different face of the die. Die is represented by a 6 element string list.

  alias BoggleEngine.Utilities

  # Converts a specification to a die.
  def make_die(specification) do
    Utilities.chunk_on_uppercase(specification)
  end
end
