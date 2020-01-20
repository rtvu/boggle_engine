defmodule BoggleEngineTest do
  use ExUnit.Case
  doctest BoggleEngine

  test "greets the world" do
    assert BoggleEngine.hello() == :world
  end
end
