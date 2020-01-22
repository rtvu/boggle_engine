defmodule BoggleEngine.Score do
  @moduledoc false

  # Calculates score from word list.
  def score_list(list, version) do
    list
    |> Enum.map(&score_word(&1, version))
    |> Enum.sum()
  end

  # Calculates the score for word.
  def score_word(word, version) do
    word
    |> String.length()
    |> score_length(version)
  end

  # Calculates score based on word length.
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
