defmodule BoggleEngine.Neighbor.Transform.StandardMap do
  @moduledoc """
  StandardMap returns states within board unchanged and errors on states
  outside of board.
  """

  alias BoggleEngine.Neighbor.Transform

  @behaviour Transform

  @impl true
  def transform(state = {:error, _neighbor, _metadata}) do
    state
  end

  def transform({:ok, neighbor, metadata = {origin, i, j, size}}) do
    x = rem(origin, size) + i
    y = div(origin, size) + j

    case {x < 0, x >= size, y < 0, y >= size} do
      {false, false, false, false} ->
        neighbor = y * size + x
        {:ok, neighbor, metadata}
      _ ->
        {:error, neighbor, metadata}
    end
  end
end
