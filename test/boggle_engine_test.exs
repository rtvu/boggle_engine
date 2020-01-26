defmodule BoggleEngineTest do
  use ExUnit.Case
  doctest BoggleEngine

  test "verify BoggleEngine functionality" do
    version = :boggle

    game = BoggleEngine.new_game(version)
    game_string = BoggleEngine.to_string(game)
    assert game == BoggleEngine.from_string(game_string, version)
    assert version == BoggleEngine.get_version(game)

    game = BoggleEngine.from_string("SAILZZZZZZZZZZZZ", version)
    solved_words = BoggleEngine.solve(game)
    assert MapSet.new(solved_words) == MapSet.new(["ail", "sail"])
    assert 2 == BoggleEngine.score(solved_words, version)
  end
end
