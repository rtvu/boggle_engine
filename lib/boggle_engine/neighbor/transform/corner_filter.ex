defmodule BoggleEngine.Neighbor.Transform.CornerFilter do
  @moduledoc """
  CornerFilter returns corner delta states unchanged and errors on edge delta
  states.
  """

  alias BoggleEngine.Neighbor.Transform

  @behaviour Transform

  @impl true
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
