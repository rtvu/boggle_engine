defmodule BoggleEngine.Solver.LexiconManager do
  @moduledoc false

  # Functions to manage lexicons.

  @lexicon_binary_path "../../../resource/lexicon.lex" |> Path.expand(__DIR__)
  @dictionary_text_path "../../../resource/dictionary.txt" |> Path.expand(__DIR__)

  # Creates lexicon from lexicon binary path
  def from_lexicon_file!(path \\ @lexicon_binary_path) do
    Lexicon.from_file!(path)
  end

  # Creates lexicon from dictionary text path.
  def from_dictionary_file!(path \\ @dictionary_text_path) do
    path
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.trim/1)
    |> Lexicon.new()
  end

  # Saves lexicon to path.
  def save!(lexicon, path) do
    Lexicon.save!(lexicon, path)
  end
end
