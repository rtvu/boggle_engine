defmodule BoggleEngine.Neighbor.Transform do
  @moduledoc false

  # A transform function takes a state and returns a new state. Status and
  # neighbor should be the only state fields that changes. Metadata is a tuple
  # containing origin, the i/j delta position from origin, and size of boggle
  # board.

  @type status() :: :ok | :error
  @type neighbor() :: nil | integer()
  @type origin() :: integer()
  @type delta() :: integer()
  @type size() :: integer()
  @type metadata() :: {origin(), delta(), delta(), size()}
  @type state() :: {status(), neighbor(), metadata()}

  @callback transform(state :: state()) :: state()
end
