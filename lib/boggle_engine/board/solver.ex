defmodule BoggleEngine.Board.Solver do
  @moduledoc """
  Functions to solve boards.
  """

  alias BoggleEngine.Board
  alias BoggleEngine.Board.Solver.Select
  alias BoggleEngine.Neighbor
  alias BoggleEngine.Score

  @lexicon_binary "../../../resource/lexicon.lex" |> Path.expand(__DIR__) |> File.read!()

  @type board :: Board.t
  @type rule :: Neighbor.rule
  @type lexicon :: Lexicon.t
  @type word :: Score.word

  @typedoc false
  @type position :: Neighbor.position
  @type neighbors :: (position -> [position])
  @type bitboard :: Select.bitboard

  @doc """
  Finds all words in board.
  """
  @spec solve(board, rule, integer) :: [word]
  def solve(board, rule, minimum_word_length) do
    lexicon = :erlang.binary_to_term(@lexicon_binary)
    solve(board, rule, minimum_word_length, lexicon)
  end

  @doc """
  Finds all words in board. Uses provided lexicon for valid words.
  """
  @spec solve(board, rule, integer, lexicon) :: [word]
  def solve(board, rule, minimum_word_length, lexicon) do
    size = Board.get_size(board)
    neighbors = &(Neighbor.get_neighbors(&1, size, rule))

    find_words(board, neighbors, minimum_word_length, lexicon)
    |> MapSet.new()
    |> MapSet.to_list()
  end

  # Initiates start of word search.
  @spec find_words(board, neighbors, integer, lexicon) :: [word]
  defp find_words(board, neighbors, minimum_word_length, lexicon) do
    size = Board.get_size(board)

    words =
      for position <- 0..(size * size - 1) do
        value = Board.get_value(board, position)
        bitboard = Select.mark_position(0, position)
        search(value, bitboard, position, board, neighbors, minimum_word_length, lexicon)
      end

    words
    |> List.flatten()
    |> Enum.map(&String.downcase/1)
  end

  # Determines whether searching neighbors is necessary for words.
  @spec search(String.t, bitboard, position, board, neighbors, integer, lexicon) :: [word]
  defp search(prefix, bitboard, position, board, neighbors, minimum_word_length, lexicon) do
    has_prefix? = Lexicon.has_prefix?(lexicon, prefix)
    words =
      if has_prefix? do
        deep_search(prefix, bitboard, position, board, neighbors, minimum_word_length, lexicon)
      else
        []
      end

    is_prefix_word? = String.length(prefix) >= minimum_word_length and Lexicon.has_word?(lexicon, prefix)
    if is_prefix_word? do
      [prefix | words]
    else
      words
    end
  end

  # Searches neighbors to make words.
  @spec deep_search(String.t, bitboard, position, board, neighbors, integer, lexicon) :: [word]
  defp deep_search(prefix, bitboard, position, board, neighbors, minimum_word_length, lexicon) do
    for next_position <- neighbors.(position),
        not Select.position_marked?(bitboard, next_position) do
      next_value = Board.get_value(board, next_position)
      next_prefix = prefix <> next_value
      next_bitboard = Select.mark_position(bitboard, next_position)

      search(next_prefix, next_bitboard, next_position, board, neighbors, minimum_word_length, lexicon)
    end
  end
end
