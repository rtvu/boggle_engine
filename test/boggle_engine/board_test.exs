defmodule BoggleEngine.BoardTest do
  use ExUnit.Case

  alias BoggleEngine.Board

  test "valid boggle boards can be determined" do
    # Not correct sizes
    assert Board.valid_board?("WURESHETOEN") == false
    assert Board.valid_board?("HeKAEEFDEEEGIIIJEDIIGHHHLIILOTSRRPROORST") == false

    # Not valid configurations
    assert Board.valid_board?("ZEBCFWURESHETZEN") == false
    assert Board.valid_board?("HeKAEEFDEEEGIZIJEDIIGHZHLIILOTSRZPROO") == false
    assert Board.valid_board?("ZZZEEFDEEEGIZIJEDIIGHZHLIILOTSRZPROO") == false

    # Valid configurations
    assert Board.valid_board?("QuEBCFWURESHETOEN") == true
    assert Board.valid_board?("HeKAEEFDEEEGIIIJEDIIGHHHLIILOTSRRPROO") == true
  end

  test "boggle board" do
    :rand.seed(:exsplus, {101, 102, 103})
    board = Board.new_board(:boggle)
    configuration_string = Board.to_string(board)
    configuration_list = Board.to_list(board)
    board_from_string = Board.from_string(configuration_string)
    board_from_list = Board.from_list(configuration_list)

    assert Board.valid_board?(board) == true
    assert board == board_from_string
    assert board == board_from_list
    assert Board.get_value(board, 0) == List.first(configuration_list)
  end

  test "big boggle board" do
    :rand.seed(:exsplus, {101, 102, 103})
    board = Board.new_board(:big_boggle)
    configuration_string = Board.to_string(board)
    configuration_list = Board.to_list(board)
    board_from_string = Board.from_string(configuration_string)
    board_from_list = Board.from_list(configuration_list)

    assert Board.valid_board?(board) == true
    assert board == board_from_string
    assert board == board_from_list
    assert Board.get_value(board, 0) == List.first(configuration_list)
  end

  test "super big boggle board" do
    :rand.seed(:exsplus, {101, 102, 103})
    board = Board.new_board(:super_big_boggle)
    configuration_string = Board.to_string(board)
    configuration_list = Board.to_list(board)
    board_from_string = Board.from_string(configuration_string)
    board_from_list = Board.from_list(configuration_list)

    assert Board.valid_board?(board) == true
    assert board == board_from_string
    assert board == board_from_list
    assert Board.get_value(board, 0) == List.first(configuration_list)
  end
end
