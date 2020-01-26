defmodule BoggleEngine.Board.DiceSet do
  @moduledoc """
  Functions to generate dice sets.

  A dice set is represented by a list of dice.
  """

  alias BoggleEngine.Board.Die

  @type t :: [die]
  @type die :: Die.t

  @doc """
  Creates a dice set from file. Each line in file defines a die.
  """
  @spec from_file(Path.t) :: t
  def from_file(path) do
    path
    |> File.read!()
    |> from_string()
  end

  @doc """
  Creates a dice set from string.
  """
  @spec from_string(String.t) :: t
  def from_string(string) do
    string
    |> String.trim()
    |> String.split()
    |> Stream.map(&String.trim/1)
    |> Enum.map(&Die.from_string/1)
  end
end
