defmodule BoggleEngine.UtilitiesTest do
  use ExUnit.Case

  alias BoggleEngine.Utilities

  test "verify chunk_string_on_uppercase/1" do
    assert [] = Utilities.chunk_string_on_uppercase("")
    assert [] = Utilities.chunk_string_on_uppercase("eld")
    assert ["#"] = Utilities.chunk_string_on_uppercase("eld#")
    assert ["#", "#"] = Utilities.chunk_string_on_uppercase("#eld#")
    assert ["#", "#"] = Utilities.chunk_string_on_uppercase("#eld#bcld")
    assert ["H", "He", "L", "D", "Oog", "L"] = Utilities.chunk_string_on_uppercase("HHeLDOogL")
    assert ["H", "He", "L", "#", "#", "D", "Oog", "L"] = Utilities.chunk_string_on_uppercase("HHeL##DOogL")
    assert ["#", "H", "He", "L", "#", "#", "D", "Oob", "#", "L", "#"] = Utilities.chunk_string_on_uppercase("#HHeL##DOob#icgL#")
  end

  test "verify uppercase?/1 and lowercase?/1" do
    assert true == Utilities.uppercase?("A")
    assert true == Utilities.uppercase?("AB")
    assert true == Utilities.uppercase?("AB#")
    assert false == Utilities.uppercase?("a")
    assert false == Utilities.uppercase?("aB")
    assert false == Utilities.uppercase?("aB#")
    assert true == Utilities.uppercase?("#")

    assert true == Utilities.lowercase?("a")
    assert true == Utilities.lowercase?("ab")
    assert true == Utilities.lowercase?("ab#")
    assert false == Utilities.lowercase?("A")
    assert false == Utilities.lowercase?("Ab")
    assert false == Utilities.lowercase?("Ab#")
    assert true == Utilities.lowercase?("#")
  end

  test "verify integer_to_string_with_padding/2" do
    assert "000" = Utilities.integer_to_string_with_padding(0, 3)
    assert "043" = Utilities.integer_to_string_with_padding(43, 3)
    assert "050" = Utilities.integer_to_string_with_padding(50, 3)
    assert "738" = Utilities.integer_to_string_with_padding(738, 3)
    assert "1738" = Utilities.integer_to_string_with_padding(1738, 3)
  end

  test "verify list_to_map_with_index/1" do
    assert %{} = Utilities.list_to_map_with_index([])
    assert %{0 => 1, 1 => 2, 2 => 3} = Utilities.list_to_map_with_index([1,2,3])
  end

  test "verify fit_list/3" do
    assert [nil, nil, nil, nil] = Utilities.fit_list([], 4, nil)
    assert [1, 2, 3, nil] = Utilities.fit_list([1, 2, 3,], 4, nil)
    assert [1, 2, 3, 4] = Utilities.fit_list([1, 2, 3, 4], 4, nil)
    assert [1, 2, 3, 4] = Utilities.fit_list([1, 2, 3, 4, 5], 4, nil)
  end
end
