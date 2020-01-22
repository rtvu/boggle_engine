defmodule BoggleEngine.Neighbor.Transform.NoneFilterTest do
  use ExUnit.Case

  alias BoggleEngine.Neighbor.Transform.NoneFilter

  test "errors are passed through" do
    assert {:error, _, _} = NoneFilter.transform({:error, nil, nil})
  end

  test "all coordinates are valid" do
    for i <- [-1, 0, 1],
        j <- [-1, 0, 1] do
      assert {:ok, _, {0, i, j, 4}} = NoneFilter.transform({:ok, nil, {0, i, j, 4}})
    end
  end
end
