defmodule BoggleEngine.Neighbor.Transform.EdgeFilter do
  @moduledoc """
  EdgeFilter returns edge delta states unchanged and errors on corner delta
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
      {:error, neighbor, metadata}
    else
      state
    end
  end
end
