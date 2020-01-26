defmodule BoggleEngine.Score do
  @moduledoc """
  Functions to calculate scores.
  """

  @type word :: String.t
  @type version :: BoggleEngine.Board.version
  @type score :: integer

  @doc """
  Calculates score for word list.
  """
  @spec score_list([word], version) :: score
  def score_list(list, version) do
    list
    |> MapSet.new()
    |> MapSet.to_list()
    |> Enum.map(&score_word(&1, version))
    |> Enum.sum()
  end

  @doc """
  Calculates score for word.
  """
  @spec score_word(word, version) :: score
  def score_word(word, version) do
    word
    |> String.length()
    |> score_length(version)
  end

  # Calculates score based on word length.
  @spec score_length(integer, version) :: score
  defp score_length(length, version)

  defp score_length(length, :boggle) do
    cond do
      length == 3 -> 1
      length == 4 -> 1
      length == 5 -> 2
      length == 6 -> 3
      length == 7 -> 4
      length >= 8 -> 11
      true -> 0
    end
  end

  defp score_length(length, :big_boggle) do
    cond do
      length == 4 -> 1
      length == 5 -> 2
      length == 6 -> 3
      length == 7 -> 5
      length >= 8 -> 11
      true -> 0
    end
  end

  defp score_length(length, :super_big_boggle) do
    cond do
      length == 4 -> 1
      length == 5 -> 2
      length == 6 -> 3
      length == 7 -> 5
      length == 8 -> 11
      length >= 9 -> length * 2
      true -> 0
    end
  end
end
