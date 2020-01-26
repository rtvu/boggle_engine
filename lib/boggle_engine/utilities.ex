defmodule BoggleEngine.Utilities do
  @moduledoc """
  Utility functions for project.
  """

  @doc """
  Takes a string and returns a list of strings separated on uppercase. Leading
  lowercase letters will be dropped. Letters that do not have cases will be
  chunked like uppercase letters. Lower case letters trailing no case letters
  will be dropped.
  """
  @spec chunk_string_on_uppercase(String.t) :: [String.t]
  def chunk_string_on_uppercase(string) do
    string
    |> String.graphemes
    |> Enum.chunk_while("", &handle_chunking/2, &handle_after_chunking/1)
  end

  # Helper function for chunk_string_on_uppercase/1 to chunk the list of
  # strings.
  @spec handle_chunking(String.grapheme, String.t | {nocase}) :: {:cont, String.t} | {:cont, String.t, String.t} | {:cont, {nocase}} | {:cont, String.t, {nocase}} when nocase: String.grapheme
  defp handle_chunking(letter, accumulator) do
    uppercase? = uppercase?(letter)
    lowercase? = lowercase?(letter)

    case {uppercase?, lowercase?, accumulator} do
      {true, true, ""} -> {:cont, {letter}}
      {true, true, {no_case_letter}} -> {:cont, no_case_letter, {letter}}
      {true, true, string} -> {:cont, string, {letter}}
      {true, false, ""} -> {:cont, letter}
      {true, false, {no_case_letter}} -> {:cont, no_case_letter, letter}
      {true, false, string} -> {:cont, string, letter}
      {false, true, ""} -> {:cont, ""}
      {false, true, {no_case_letter}} -> {:cont, no_case_letter, ""}
      {false, true, string} -> {:cont, string <> letter}
    end
  end

  # Helper function for chunk_string_on_uppercase/1 to handle the last
  # accumulator value.
  @spec handle_after_chunking(String.t | {nocase}) :: {:cont, String.t} | {:cont, String.t, String.t} | {:cont, nocase, String.t} when nocase: String.grapheme
  defp handle_after_chunking(accumulator) do
    case accumulator do
      "" -> {:cont, ""}
      {no_case_letter} -> {:cont, no_case_letter, ""}
      string -> {:cont, string, ""}
    end
  end

  @doc """
  Determines if string is uppercase. A string is uppercase if it does not
  contain lowercase letters.
  """
  @spec uppercase?(String.t) :: boolean
  def uppercase?(string) do
    string == String.upcase(string)
  end

  @doc """
  Determines if string is lowercase. A string is lowercase if it does not
  contain uppercase letters.
  """
  @spec lowercase?(String.t) :: boolean
  def lowercase?(string) do
    string == String.downcase(string)
  end

  @doc """
  Converts integer to string representation with 0s as lead padding.
  """
  @spec integer_to_string_with_padding(integer, integer) :: String.t
  def integer_to_string_with_padding(integer, count) do
    integer
    |> Integer.to_string()
    |> String.pad_leading(count, "0")
  end

  @doc """
  Converts list to a map where key is the position of value in list.
  """
  @spec list_to_map_with_index([term]) :: %{required(integer) => term}
  def list_to_map_with_index(list) do
    for {value, key} <- Enum.with_index(list), into: %{} do
      {key, value}
    end
  end

  @doc """
  List will be truncated if longer than count. List will have filler appended
  if shorter than count.
  """
  @spec fit_list([term], integer, term) :: [term]
  def fit_list(list, count, filler) do
    fit_list(list, count, filler, [])
  end

  @spec fit_list([term], integer, term, [term]) :: [term]
  defp fit_list(_configuration, 0, _filler, result) do
    Enum.reverse(result)
  end

  defp fit_list([], count, filler, result) do
    result =
      for _i <- 1..count, reduce: result do
        result -> [filler | result]
      end

    Enum.reverse(result)
  end

  defp fit_list([first | rest], count, filler, result) do
    count = count - 1
    result = [first | result]
    fit_list(rest, count, filler, result)
  end
end
