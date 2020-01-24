defmodule BoggleEngine.Utilities do
  @moduledoc false

  # Takes a string and returns a list of strings separated on uppercase.
  # Leading lowercase letters will be dropped. Letters that do not have cases
  # will be chunked like uppercase letters. Lower case letters trailing no case
  # letters will be dropped.
  def chunk_string_on_uppercase(string) do
    string
    |> String.graphemes
    |> Enum.chunk_while("", &handle_chunking/2, &handle_after_chunking/1)
  end

  # Helper function for chunk_string_on_uppercase/1 to chunk the list of
  # strings.
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
  defp handle_after_chunking(accumulator) do
    case accumulator do
      "" -> {:cont, ""}
      {no_case_letter} -> {:cont, no_case_letter, ""}
      string -> {:cont, string, ""}
    end
  end

  # Determines if letter is uppercase.
  def uppercase?(letter) do
    letter == String.upcase(letter)
  end


  # Determines if letter is lowercase.
  def lowercase?(letter) do
    letter == String.downcase(letter)
  end

  # Converts integer to string representation with 0s as lead padding.
  def integer_to_string_with_padding(integer, count) do
    integer
    |> Integer.to_string()
    |> String.pad_leading(count, "0")
  end
end
