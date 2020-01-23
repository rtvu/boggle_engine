defmodule BoggleEngine.Board.DiceSet do
  @moduledoc false

  # A dice set is represented by a list of dice.

  alias BoggleEngine.Board.Die

  # Gets a dice set from file.
  def from_file(path) do
    path
    |> File.read!()
    |> from_string()
  end

  # Gets a dice set from string.
  def from_string(string) do
    string
    |> String.trim()
    |> String.split()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.graphemes/1)
    |> Enum.map(&Die.make_die/1)
  end
end
