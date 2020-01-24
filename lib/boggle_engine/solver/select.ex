defmodule BoggleEngine.Solver.Select do
  @moduledoc false

  # Positions of a board can be represented by a bitstring.

  use Bitwise

  # Determines if position is marked in board.
  def position_marked?(board, position) do
    (board &&& 1 <<< position) >>> position == 1
  end

  # Marks position in board.
  def mark_position(board, position) do
    board ||| 1 <<< position
  end

  # Unmarks position in board.
  def unmark_position(board, position) do
    board &&& ~~~(1 <<< position)
  end
end
