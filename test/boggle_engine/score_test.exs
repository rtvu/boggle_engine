defmodule BoggleEngine.ScoreTest do
  use ExUnit.Case

  alias BoggleEngine.Score

  test "verify scoring" do
    list = ["do", "say", "rock", "rowwing", "dendrites", "photography"]
    assert Score.score_list(list, :boggle) == 28
    assert Score.score_list(list, :big_boggle) == 28
    assert Score.score_list(list, :super_big_boggle) == 46
  end
end
