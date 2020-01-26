defmodule BoggleEngine.Neighbor.Transform do
  @moduledoc """
  A transform function takes a state and returns a new state. Status and
  neighbor should be the only state fields that changes. Metadata is a tuple
  containing origin, the i/j delta positions from origin, and size of boggle
  board.
  """

  alias BoggleEngine.Neighbor

  @type status :: :ok | :error
  @type position :: Neighbor.position
  @type neighbor :: nil | position
  @type origin :: position
  @type delta :: integer
  @type size :: integer
  @type metadata :: {origin, i :: delta, j :: delta, size}
  @type state :: {status, neighbor, metadata}
  @type transform :: (state -> state)

  @callback transform(state :: state) :: state
end
