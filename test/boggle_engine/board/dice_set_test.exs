defmodule BoggleEngine.Board.DiceSetTest do
  use ExUnit.Case

  alias BoggleEngine.Board.DiceSet

  setup_all do
    dice_set =
      [
        ["H", "I", "M", "N", "U", "Qu"],
        ["A", "A", "E", "E", "G", "N"],
        ["A", "B", "B", "J", "O", "O"]
      ]
      |> Enum.map(&Enum.sort/1)

    %{dice_set: dice_set}
  end

  test "from file", context do
    from_file_dice_set =
      "dice_set_test/sample_dice_set.txt"
      |> Path.expand(__DIR__)
      |> DiceSet.from_file()
      |> Enum.map(&Enum.sort/1)

    assert from_file_dice_set == context[:dice_set]
  end

  test "from string", context do
    from_string_dice_set =
      "HIMNUQu\nAAEEGN\nABBJOO"
      |> DiceSet.from_string()
      |> Enum.map(&Enum.sort/1)

    assert from_string_dice_set == context[:dice_set]
  end
end
