defmodule BoggleEngine.Neighbor.Transform.EdgeFilter do
  @moduledoc false

  # Only edge deltas are allowed.

  alias BoggleEngine.Neighbor.Transform

  @behaviour Transform

  @impl Transform
  def transform(state = {:error, _neighbor, _metadata}) do
    state
  end

  def transform(state = {:ok, neighbor, metadata = {_origin, i, j, _size}}) do
    if abs(i) + abs(j) == 2 do
      {:error, neighbor, metadata}
    else
      state
    end
  end
end
