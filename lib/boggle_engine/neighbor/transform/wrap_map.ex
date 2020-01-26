defmodule BoggleEngine.Neighbor.Transform.WrapMap do
  @moduledoc """
  WrapMap returns states within board unchanged and returns states outside of
  board wrapped back into board.
  """

  alias BoggleEngine.Neighbor.Transform

  @behaviour Transform

  @impl true
  def transform(state = {:error, _neighbor, _metadata}) do
    state
  end

  def transform({:ok, _neighbor, metadata = {origin, i, j, size}}) do
    x = rem(origin, size) + i
    y = div(origin, size) + j

    x = remap(x, size)
    y = remap(y, size)

    neighbor = y * size + x

    {:ok, neighbor, metadata}
  end

  defp remap(coord, size) do
    cond do
      coord < 0 -> size - 1
      coord >= size -> 0
      true -> coord
    end
  end
end
