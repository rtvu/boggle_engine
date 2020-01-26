defmodule BoggleEngine.Board.Solver.LexiconManager do
  @moduledoc """
  Functions to manage lexicons.
  """

  @lexicon_binary_path "../../../../resource/lexicon.lex" |> Path.expand(__DIR__)
  @dictionary_text_path "../../../../resource/dictionary.txt" |> Path.expand(__DIR__)

  @doc false
  @spec from_lexicon_file!() :: Lexicon.t
  def from_lexicon_file!() do
    from_lexicon_file!(@lexicon_binary_path)
  end

  @doc """
  Creates lexicon from lexicon binary path
  """
  @spec from_lexicon_file!(Path.t) :: Lexicon.t
  def from_lexicon_file!(path) do
    Lexicon.from_file!(path)
  end

  @doc false
  @spec from_dictionary_file!() :: Lexicon.t
  def from_dictionary_file!() do
    from_dictionary_file!(@dictionary_text_path)
  end

  @doc """
  Creates lexicon from dictionary text path.
  """
  @spec from_dictionary_file!(Path.t) :: Lexicon.t
  def from_dictionary_file!(path) do
    path
    |> File.read!()
    |> String.split()
    |> Enum.map(&String.trim/1)
    |> Lexicon.new()
  end

  @doc """
  Saves lexicon to path.
  """
  @spec save!(Lexicon.t, Path.t) :: :ok
  def save!(lexicon, path) do
    Lexicon.save!(lexicon, path)
  end
end
