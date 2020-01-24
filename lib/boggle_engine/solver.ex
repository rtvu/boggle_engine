defmodule BoggleEngine.Solver do
  @moduledoc false

  alias BoggleEngine.Board
  alias BoggleEngine.Neighbor
  alias BoggleEngine.Solver.Select

  @lexicon_binary "../../resource/lexicon.lex" |> Path.expand(__DIR__) |> File.read!()

  # Finds all words in board.
  def solve(board, rules, minimum_word_length, lexicon \\ @lexicon_binary)

  def solve(board, rules, minimum_word_length, lexicon) when is_binary(lexicon) do
    lexicon = :erlang.binary_to_term(@lexicon_binary)
    solve(board, rules, minimum_word_length, lexicon)
  end

  def solve(board, rules, minimum_word_length, lexicon) do
    size = Board.get_size(board)
    get_neighbors = &(Neighbor.get_neighbors(&1, size, rules))

    find_words(board, get_neighbors, minimum_word_length, lexicon)
    |> MapSet.new()
    |> MapSet.to_list()
  end

  # Initiates head of word search.
  defp find_words(board, get_neighbors, minimum_word_length, lexicon) do
    size = Board.get_size(board)

    words =
      for position <- 0..(size * size - 1) do
        value = Board.get_value(board, position)
        bit_board = Select.mark_position(0, position)
        search(value, bit_board, position, board, get_neighbors, minimum_word_length, lexicon)
      end

    List.flatten(words)
  end

  # Determines whether searching neighbors is necessary for words.
  defp search(prefix, bit_board, position, board, get_neighbors, minimum_word_length, lexicon) do
    has_prefix? = Lexicon.has_prefix?(lexicon, prefix)
    words =
      if has_prefix? do
        deep_search(prefix, bit_board, position, board, get_neighbors, minimum_word_length, lexicon)
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
  defp deep_search(prefix, bit_board, position, board, get_neighbors, minimum_word_length, lexicon) do
    for next_position <- get_neighbors.(position),
        not Select.position_marked?(bit_board, next_position) do
      next_value = Board.get_value(board, next_position)
      next_prefix = prefix <> next_value
      next_bit_board = Select.mark_position(bit_board, next_position)

      search(next_prefix, next_bit_board, next_position, board, get_neighbors, minimum_word_length, lexicon)
    end
  end
end
