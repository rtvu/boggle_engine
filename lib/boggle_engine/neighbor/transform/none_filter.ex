defmodule BoggleEngine.Neighbor.Transform.NoneFilter do
  @moduledoc false

  # All deltas are allowed.

  alias BoggleEngine.Neighbor.Transform

  @behaviour Transform

  @impl Transform
  def transform(state) do
    state
  end
end
