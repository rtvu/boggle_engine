defmodule BoggleEngine.Board do
  @moduledoc """
  Functions to create and interact with Boggle board.
  """

  alias BoggleEngine.Board
  alias BoggleEngine.Board.DiceSet
  alias BoggleEngine.Neighbor
  alias BoggleEngine.Utilities

  @boggle_set "../../resource/boggle.txt" |> Path.expand(__DIR__) |> DiceSet.from_file()
  @big_boggle_set "../../resource/big_boggle.txt" |> Path.expand(__DIR__) |> DiceSet.from_file()
  @super_big_boggle_set "../../resource/super_big_boggle.txt" |> Path.expand(__DIR__) |> DiceSet.from_file()
  @dice_sets %{boggle: @boggle_set, big_boggle: @big_boggle_set, super_big_boggle: @super_big_boggle_set}
  @board_sizes %{boggle: 4, big_boggle: 5, super_big_boggle: 6}

  defstruct [:configuration, :version]

  @type t :: %__MODULE__{
                configuration: %{required(position) => tile},
                version: version
              }
  @type version :: :boggle | :big_boggle | :super_big_boggle
  @type tile :: String.grapheme | String.t
  @type position :: Neighbor.position
  @type size :: 4 | 5 | 6

  @doc """
  Creates a random board based on version.
  """
  @spec new_board(version) :: t
  def new_board(version) do
    version
    |> roll_dice()
    |> from_list(version)
  end

  @doc """
  Creates a board from configuration string. Each board position is defined by
  an uppercase letter followed by optional lowercase letters. Configuration will
  be truncated if longer than board. Configuration will have blanks appended if
  shorter than board.
  """
  @spec from_string(String.t, version) :: t
  def from_string(string, version) do
    string
    |> Utilities.chunk_string_on_uppercase()
    |> from_list(version)
  end

  @doc """
  Creates a board from configuration list of strings. Configuration will be
  truncated if longer than board. Configuration will have blanks appended if
  shorter than board.
  """
  @spec from_list([tile], version) :: t
  def from_list(list, version) do
    size = get_size(version)
    configuration =
      list
      |> Utilities.fit_list(size * size, "#")
      |> Utilities.list_to_map_with_index()
    %Board{configuration: configuration, version: version}
  end

  @doc """
  Gets board configuration as a string.
  """
  @spec to_string(t) :: String.t
  def to_string(board = %Board{}) do
    board
    |> to_list()
    |> List.to_string()
  end

  @doc """
  Gets board configuration as a list of strings.
  """
  @spec to_list(t) :: [tile]
  def to_list(%Board{configuration: configuration, version: version}) do
    size = get_size(version)
    for position <- 0..(size * size - 1) do
      configuration[position]
    end
  end

  @doc """
  Gets value based on board position.
  """
  @spec get_value(t, position) :: tile
  def get_value(%Board{configuration: configuration}, position) do
    configuration[position]
  end

  @doc """
  Gets board size.
  """
  @spec get_size(t | version) :: size
  def get_size(%Board{version: version}) do
    get_size(version)
  end

  def get_size(version) do
    @board_sizes[version]
  end

  @doc """
  Gets version.
  """
  @spec get_version(t) :: version
  def get_version(%Board{version: version}) do
    version
  end

  # Creates a random configuration based on version.
  @spec roll_dice(version) :: [tile]
  defp roll_dice(version) do
    @dice_sets[version]
    |> Enum.map(&Enum.random/1)
    |> Enum.shuffle()
  end

  @doc """
  Verifies board is a valid Boggle game. Accepts `%Board{}`, string, or list of
  strings.
  """
  @spec valid_board?(t | String.t | [tile]) :: boolean
  def valid_board?(board = %Board{}) do
    board
    |> to_list()
    |> valid_board?()
  end

  def valid_board?(string) when is_binary(string) do
    string
    |> Utilities.chunk_string_on_uppercase()
    |> valid_board?()
  end

  def valid_board?(list) when is_list(list) do
    length = length(list)
    if length not in [16, 25, 36] do
      false
    else
      version =
        case length do
          16 -> :boggle
          25 -> :big_boggle
          36 -> :super_big_boggle
        end

      dice =
        @dice_sets[version]
        |> Enum.map(&MapSet.new/1)

      verify_configuration(list, dice, length)
    end
  end

  # Verifies configuration is valid by determining whether there are any
  # mismatches between configuration and dice.
  @spec verify_configuration([tile], [tile], integer) :: boolean
  defp verify_configuration(configuration, dice, length) do
    # Runs matching problem in a separate process to avoid manually handling
    # garbage collection.
    {matches, _flow_details} =
      Task.async(fn -> match_faces_to_dice(configuration, dice, length) end)
      |> Task.await()

    # Configuration is only valid if there are no mismatches.
    matches == length
  end

  # Generates list of maximum matches of faces and dice. This problem can be
  # structured as a bipartite graph and solved by finding the maximum flow.
  @spec match_faces_to_dice([tile], [tile], integer) :: :graph_lib.flow | (error :: {charlist, charlist})
  defp match_faces_to_dice(faces, dice, length) do
    graph = build_base_graph(length)

    # Adds an edge to graph for each face/die combination where face is on die.
    for {face, face_index} <- Enum.with_index(faces),
        {die, die_index} <- Enum.with_index(dice),
        MapSet.member?(die, face) do
      face_vertex = "f" <> Utilities.integer_to_string_with_padding(face_index + 1, 2)
      die_vertex = "d" <> Utilities.integer_to_string_with_padding(die_index + 1, 2)
      :graph.add_edge(graph, face_vertex, die_vertex)
    end

    # Solves for maximum flow. `:dfs` mode will use Ford-Fulkerson algorithm.
    :edmonds_karp.run(graph, "source", "sink", :dfs)
  end

  # Builds base graph specified by length.
  @spec build_base_graph(integer) :: :graph.graph
  defp build_base_graph(length) do
    # Creates empty graph, adds source vertex, and adds sink vertex
    graph = :graph.empty(:directed, :d)
    :graph.add_vertex(graph, "source")
    :graph.add_vertex(graph, "sink")

    # Adds face vertices, die vertices, source to face edges, and die to sink
    # edges.
    for index <- 1..length do
      formatted_index = Utilities.integer_to_string_with_padding(index, 2)
      face_vertex = "f" <> formatted_index
      die_vertex = "d" <> formatted_index

      :graph.add_vertex(graph, face_vertex)
      :graph.add_vertex(graph, die_vertex)
      :graph.add_edge(graph, "source", face_vertex)
      :graph.add_edge(graph, die_vertex, "sink")
    end

    graph
  end
end
