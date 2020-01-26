defmodule BoggleEngine.Board.Solver.Select do
  @moduledoc """
  Functions to manipulate bitboard occupied states.

  Bitboard occupied states are represented by bitstrings.
  """

  use Bitwise

  alias BoggleEngine.Neighbor

  @type bitboard :: integer
  @type position :: Neighbor.position

  @doc """
  Determines if position is marked in bitboard.
  """
  @spec position_marked?(bitboard, position) :: true
  def position_marked?(bitboard, position) do
    (bitboard &&& 1 <<< position) >>> position == 1
  end

  @doc """
  Marks position on bitboard.
  """
  @spec mark_position(bitboard, position) :: bitboard
  def mark_position(bitboard, position) do
    bitboard ||| 1 <<< position
  end

  @doc """
  Unmarks position in bitboard.
  """
  @spec unmark_position(bitboard, position) :: bitboard
  def unmark_position(bitboard, position) do
    bitboard &&& ~~~(1 <<< position)
  end
end
