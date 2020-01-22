defmodule BoggleEngine.NeighborTest do
  use ExUnit.Case

  alias BoggleEngine.Neighbor

  test "boggle corner with standard rules" do
    upper_left_corner = Neighbor.get_neighbors(0, 4, :standard)
    upper_right_corner = Neighbor.get_neighbors(3, 4, :standard)
    lower_left_corner = Neighbor.get_neighbors(12, 4, :standard)
    lower_right_corner = Neighbor.get_neighbors(15, 4, :standard)

    assert MapSet.new(upper_left_corner) == MapSet.new([1, 4, 5])
    assert MapSet.new(upper_right_corner) == MapSet.new([2, 6, 7])
    assert MapSet.new(lower_left_corner) == MapSet.new([8, 9, 13])
    assert MapSet.new(lower_right_corner) == MapSet.new([10, 11, 14])
  end

  test "boggle inner position with standard rules" do
    position5_neighbors = Neighbor.get_neighbors(5, 4, :standard)

    assert MapSet.new(position5_neighbors) == MapSet.new([0, 1, 2, 4, 6, 8, 9, 10])
  end

  test "boggle upper left corner with wrap rules" do
    upper_left_corner = Neighbor.get_neighbors(0, 4, :wrap)

    assert MapSet.new(upper_left_corner) == MapSet.new([1, 3, 4, 5, 7, 12, 13, 15])
  end

  test "boggle inner position with wrap rules" do
    position5_neighbors = Neighbor.get_neighbors(5, 4, :wrap)

    assert MapSet.new(position5_neighbors) == MapSet.new([0, 1, 2, 4, 6, 8, 9, 10])
  end

  test "boggle corner with edge rules" do
    upper_left_corner = Neighbor.get_neighbors(0, 4, :edge)
    upper_right_corner = Neighbor.get_neighbors(3, 4, :edge)
    lower_left_corner = Neighbor.get_neighbors(12, 4, :edge)
    lower_right_corner = Neighbor.get_neighbors(15, 4, :edge)

    assert MapSet.new(upper_left_corner) == MapSet.new([1, 4])
    assert MapSet.new(upper_right_corner) == MapSet.new([2, 7])
    assert MapSet.new(lower_left_corner) == MapSet.new([8, 13])
    assert MapSet.new(lower_right_corner) == MapSet.new([11, 14])
  end

  test "boggle corner with corner rules" do
    upper_left_corner = Neighbor.get_neighbors(0, 4, :corner)
    upper_right_corner = Neighbor.get_neighbors(3, 4, :corner)
    lower_left_corner = Neighbor.get_neighbors(12, 4, :corner)
    lower_right_corner = Neighbor.get_neighbors(15, 4, :corner)

    assert MapSet.new(upper_left_corner) == MapSet.new([5])
    assert MapSet.new(upper_right_corner) == MapSet.new([6])
    assert MapSet.new(lower_left_corner) == MapSet.new([9])
    assert MapSet.new(lower_right_corner) == MapSet.new([10])
  end

  test "boggle corner with edge_wrap rules" do
    upper_left_corner = Neighbor.get_neighbors(0, 4, :edge_wrap)
    upper_right_corner = Neighbor.get_neighbors(3, 4, :edge_wrap)
    lower_left_corner = Neighbor.get_neighbors(12, 4, :edge_wrap)
    lower_right_corner = Neighbor.get_neighbors(15, 4, :edge_wrap)

    assert MapSet.new(upper_left_corner) == MapSet.new([1, 3, 4, 12])
    assert MapSet.new(upper_right_corner) == MapSet.new([0, 2, 7, 15])
    assert MapSet.new(lower_left_corner) == MapSet.new([0, 8, 13, 15])
    assert MapSet.new(lower_right_corner) == MapSet.new([3, 11, 12, 14])
  end

  test "boggle corner with corner_wrap rules" do
    upper_left_corner = Neighbor.get_neighbors(0, 4, :corner_wrap)
    upper_right_corner = Neighbor.get_neighbors(3, 4, :corner_wrap)
    lower_left_corner = Neighbor.get_neighbors(12, 4, :corner_wrap)
    lower_right_corner = Neighbor.get_neighbors(15, 4, :corner_wrap)

    assert MapSet.new(upper_left_corner) == MapSet.new([5, 7, 13, 15])
    assert MapSet.new(upper_right_corner) == MapSet.new([4, 6, 12, 14])
    assert MapSet.new(lower_left_corner) == MapSet.new([1, 3, 9, 11])
    assert MapSet.new(lower_right_corner) == MapSet.new([0, 2, 8, 10])
  end
end
