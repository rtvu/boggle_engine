defmodule BoggleEngine.Neighbor.Transform.WrapMapTest do
  use ExUnit.Case

  alias BoggleEngine.Neighbor.Transform.WrapMap

  test "errors are passed through" do
    assert {:error, _, _} = WrapMap.transform({:error, nil, nil})
  end

  test "boggle inner corners are valid" do
    assert {:ok, 0, {5, -1, -1, 4}} = WrapMap.transform({:ok, nil, {5, -1, -1, 4}})
    assert {:ok, 3, {6, 1, -1, 4}} = WrapMap.transform({:ok, nil, {6, 1, -1, 4}})
    assert {:ok, 12, {9, -1, 1, 4}} = WrapMap.transform({:ok, nil, {9, -1, 1, 4}})
    assert {:ok, 15, {10, 1, 1, 4}} = WrapMap.transform({:ok, nil, {10, 1, 1, 4}})
  end

  test "super big boggle inner corners are valid" do
    assert {:ok, 0, {7, -1, -1, 6}} = WrapMap.transform({:ok, nil, {7, -1, -1, 6}})
    assert {:ok, 5, {10, 1, -1, 6}} = WrapMap.transform({:ok, nil, {10, 1, -1, 6}})
    assert {:ok, 30, {25, -1, 1, 6}} = WrapMap.transform({:ok, nil, {25, -1, 1, 6}})
    assert {:ok, 35, {28, 1, 1, 6}} = WrapMap.transform({:ok, nil, {28, 1, 1, 6}})
  end

  test "boggle upper left outer corner are valid" do
    assert {:ok, 3, {0, -1, 0, 4}} = WrapMap.transform({:ok, nil, {0, -1, 0, 4}})
    assert {:ok, 15, {0, -1, -1, 4}} = WrapMap.transform({:ok, nil, {0, -1, -1, 4}})
    assert {:ok, 12, {0, 0, -1, 4}} = WrapMap.transform({:ok, nil, {0, 0, -1, 4}})
  end

  test "boggle lower right outer corner are valid" do
    assert {:ok, 12, {15, 1, 0, 4}} = WrapMap.transform({:ok, nil, {15, 1, 0, 4}})
    assert {:ok, 0, {15, 1, 1, 4}} = WrapMap.transform({:ok, nil, {15, 1, 1, 4}})
    assert {:ok, 3, {15, 0, 1, 4}} = WrapMap.transform({:ok, nil, {15, 0, 1, 4}})
  end
end
