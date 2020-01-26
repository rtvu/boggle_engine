defmodule BoggleEngine do
  @moduledoc """
  Boggle board generator and solver.

  Versions:
    * `:boggle` - 4x4
    * `:big_boggle` - 5x5
    * `:super_big_boggle` - 6x6

  Rules:
  * `:standard` - All neighbors are valid
  * `:edge` - Only edge neighbors
  * `:corner` - Only corner neighbors
  * `:wrap` - Out of bounds will map to neighbors
  * `:edge_wrap` - Only edge neighbors that are out of bounds will remap
  * `:corner_wrap` - Only corner neighbors that are out of bounds will remap

  # Example

      game = BoggleEngine.new_game(:boggle)
      board_string = BoggleEngine.to_string(game)
      words = BoggleEngine.solve(game)
      score = BoggleEngine.score(words, :boggle)

  """

  alias BoggleEngine.Board
  alias BoggleEngine.Board.Solver
  alias BoggleEngine.Neighbor
  alias BoggleEngine.Score

  @minimum_word_length %{boggle: 3, big_boggle: 4, super_big_boggle: 4}

  defstruct [:board]

  @type t ::  %__MODULE__{
                board: Board.t
              }
  @type rule :: Neighbor.rule
  @type version :: Board.version
  @type score :: Score.score

  @doc """
  Creates new `BoggleEngine` game.

  ## Examples

      iex> BoggleEngine.new_game(:boggle)
      #BoggleEngine<version: boggle>

  """
  @spec new_game(version) ::  t
  def new_game(version) do
    board = Board.new_board(version)
    %BoggleEngine{board: board}
  end

  @doc """
  Creates `BoggleEngine` game from string. String will be truncated if bigger
  than board. String will have blanks appended if shorter than board. Each board
  tile will start with an uppercase letter and may optionally contain trailing
  lowercase letters.

  ## Examples

      iex> BoggleEngine.from_string("SAILZZZZZZZZZZZZ", :boggle)
      #BoggleEngine<version: boggle>

  """
  @spec from_string(String.t, version) :: t
  def from_string(string, version) do
    board = Board.from_string(string, version)
    %BoggleEngine{board: board}
  end

  @doc """
  Gets string representation of `BoggleEngine`'s board.

  ## Examples

      iex> game = BoggleEngine.from_string("SAILZZZZZZZZZZZZ", :boggle)
      iex> BoggleEngine.to_string(game)
      "SAILZZZZZZZZZZZZ"

  """
  @spec to_string(t) :: String.t
  def to_string(%BoggleEngine{board: board}) do
    Board.to_string(board)
  end

  @doc """
  Gets version of `BoggleEngine` game.

  ## Examples

      iex> game = BoggleEngine.new_game(:boggle)
      iex> BoggleEngine.get_version(game)
      :boggle

  """
  @spec get_version(t) :: version
  def get_version(%BoggleEngine{board: board}) do
    Board.get_version(board)
  end

  @doc """
  Finds all words on board.

  ## Options

    * `:rule` - Default is `:standard`. Present rules are specified by their
      atoms. Custom rules are defined by a transform function.
    * `:minimum_word_length` - Default is 3 for Boggle and 4 for Big Boggle and
      Super Big Boggle.
    * `:lexicon` - Default is built-in lexicon. Accepts custom lexicon from
      `Lexicon`.

  ## Examples

      iex> game = BoggleEngine.from_string("SAILZZZZZZZZZZZZ", :boggle)
      iex> BoggleEngine.solve(game) |> Enum.sort()
      ["ail", "sail"]

  """
  @spec solve(t, keyword) ::  [String.t]
  def solve(%BoggleEngine{board: board}, options \\ []) do
    rule = Keyword.get(options, :rule, :standard)

    version = Board.get_version(board)
    minimum_word_length = Keyword.get(options, :minimum_word_length, @minimum_word_length[version])

    solve_options =
      if Keyword.has_key?(options, :lexicon) do
        lexicon = Keyword.get(options, :lexicon)
        [lexicon: lexicon]
      else
        []
      end

    Solver.solve(board, rule, minimum_word_length, solve_options)
  end

  @doc """
  Calculates score of word list.

  ## Examples

      iex> list = ["ail", "sail"]
      iex> BoggleEngine.score(list, :boggle)
      2

  """
  @spec score([String.t], version) :: score
  def score(list, version) do
    Score.score_list(list, version)
  end

  defimpl Inspect do
    def inspect(%BoggleEngine{board: board}, _opts) do
      version = Board.get_version(board)
      "#BoggleEngine<version: #{version}>"
    end
  end
end
