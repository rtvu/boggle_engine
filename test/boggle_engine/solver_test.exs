defmodule BoggleEngine.SolverTest do
  use ExUnit.Case

  alias BoggleEngine.Board
  alias BoggleEngine.Solver

  test "simple boggle" do
    board = Board.from_string("SAILZZZZZZZZZZZZ", :boggle)
    rules = :standard
    minimum_word_length = 3
    solved_words = Solver.solve(board, rules, minimum_word_length)
    formatted_solved_words = Enum.map(solved_words, &String.downcase/1)

    assert MapSet.new(formatted_solved_words) == MapSet.new(["ail", "sail"])
  end

  test "harder boggle" do
    board = Board.from_string("EAZZTZZZZZZZZZZZ", :boggle)
    rules = :standard
    minimum_word_length = 3
    solved_words = Solver.solve(board, rules, minimum_word_length)
    formatted_solved_words = Enum.map(solved_words, &String.downcase/1)

    assert MapSet.new(formatted_solved_words) == MapSet.new(["ate", "eat", "eta", "tae", "tazze", "tea", "zeta"])
  end
end
