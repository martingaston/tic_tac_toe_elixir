defmodule IOTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "get_position returns a zero-indexed number" do
    {:ok, io} = StringIO.open("1")
    assert TicTacToe.Io.get_position(io) == 0
  end

  test "get_position repeats until valid numerical input is provided" do
    {:ok, io} = StringIO.open("cat1\n2")
    assert TicTacToe.Io.get_position(io) == 1
  end

  test "TicTacToe.Io.output/2 returns the string passed in" do
    capture_io(fn ->
      output = TicTacToe.Io.output(:stdio, "the quick brown fox")
      send(self(), output)
    end)

    assert_received("the quick brown fox")
  end
end
