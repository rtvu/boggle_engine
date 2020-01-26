defmodule BoggleEngine.Board.Solver.Select do
  @moduledoc """
  Functions to manipulate board occupied states.

  Board occupied states are represented by bitstrings.
  """

  use Bitwise

  @type board :: integer
  @type position :: integer

  @doc """
  Determines if position is marked in board.
  """
  @spec position_marked?(board, position) :: true
  def position_marked?(board, position) do
    (board &&& 1 <<< position) >>> position == 1
  end

  @doc """
  Marks position on board.
  """
  @spec mark_position(board, position) :: board
  def mark_position(board, position) do
    board ||| 1 <<< position
  end

  @doc """
  Unmarks position in board.
  """
  @spec unmark_position(board, position) :: board
  def unmark_position(board, position) do
    board &&& ~~~(1 <<< position)
  end
end
