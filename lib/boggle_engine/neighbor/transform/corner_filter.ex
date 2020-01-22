defmodule BoggleEngine.Neighbor.Transform.CornerFilter do
  @moduledoc false

  # Only corner deltas are allowed.

  alias BoggleEngine.Neighbor.Transform

  @behaviour Transform

  @impl Transform
  def transform(state = {:error, _neighbor, _metadata}) do
    state
  end

  def transform(state = {:ok, neighbor, metadata = {_origin, i, j, _size}}) do
    if abs(i) + abs(j) == 2 do
      state
    else
      {:error, neighbor, metadata}
    end
  end
end
