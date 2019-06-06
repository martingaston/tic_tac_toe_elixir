defmodule IOTest do
  use ExUnit.Case

  test "get_position returns a zero-indexed number" do
    {:ok, io} = StringIO.open("1")
    assert TicTacToe.Io.get_position(io) == 0
  end

  test "get_position repeats until valid numerical input is provided" do
    {:ok, io} = StringIO.open("cat1\n2")
    assert TicTacToe.Io.get_position(io) == 1
  end
end
