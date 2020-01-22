defmodule BoggleEngine.Neighbor.Transform.EdgeFilterTest do
  use ExUnit.Case

  alias BoggleEngine.Neighbor.Transform.EdgeFilter

  test "errors are passed through" do
    assert {:error, _, _} = EdgeFilter.transform({:error, nil, nil})
  end

  test "edge coordinates are valid" do
    for i <- [-1, 0, 1],
        j <- [-1, 0, 1],
        abs(i) + abs(j) != 2 do
      assert {:ok, _, {0, i, j, 4}} = EdgeFilter.transform({:ok, nil, {0, i, j, 4}})
    end
  end

  test "corner coordinates are not valid" do
    for i <- [-1, 0, 1],
        j <- [-1, 0, 1],
        abs(i) + abs(j) == 2 do
      assert {:error, _, {0, i, j, 4}} = EdgeFilter.transform({:ok, nil, {0, i, j, 4}})
    end
  end
end
