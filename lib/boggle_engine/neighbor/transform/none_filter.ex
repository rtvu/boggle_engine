defmodule BoggleEngine.Neighbor.Transform.NoneFilter do
  @moduledoc """
  NoneFilter returns all states unchanged.
  """

  alias BoggleEngine.Neighbor.Transform

  @behaviour Transform

  @impl true
  def transform(state) do
    state
  end
end
