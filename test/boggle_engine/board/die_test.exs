defmodule BoggleEngine.Board.DieTest do
  use ExUnit.Case

  alias BoggleEngine.Board.Die

  defp format_die(string) do
    string
    |> Die.from_string()
    |> Enum.sort()
  end

  test "simple die" do
    assert format_die("AAEEGN") == Enum.sort(["A", "A", "E", "E", "G", "N"])
    assert format_die("ABBJOO") == Enum.sort(["A", "B", "B", "J", "O", "O"])
    assert format_die("ACHOPS") == Enum.sort(["A", "C", "H", "O", "P", "S"])
  end

  test "complex die" do
    assert format_die("HIMNUQu") == Enum.sort(["H", "I", "M", "N", "U", "Qu"])
    assert format_die("AnErHeInQuTh") == Enum.sort(["An", "Er", "He", "In", "Qu", "Th"])
    assert format_die("JKQuWXZ") == Enum.sort(["J", "K", "Qu", "W", "X", "Z"])
  end
end
