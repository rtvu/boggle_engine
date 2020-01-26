defmodule BoggleEngine.Board.Die do
  @moduledoc """
  Functions to generate a die.

  A die is specified by a 6 element list of faces. Each face of the die
  contains either a single non-case letter or an uppercase letter followed by
  optional lowercase letters.
  """

  alias BoggleEngine.Utilities

  @type t :: [face]
  @type face :: String.grapheme | String.t

  @doc """
  Creates a die from string.
  """
  @spec from_string(String.t) :: t
  def from_string(string) do
    Utilities.chunk_string_on_uppercase(string)
  end
end
