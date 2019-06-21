defmodule IOTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "IO.input/1 gets input from the user" do
    input_string = "to be or not to be"
    {:ok, io} = StringIO.open(input_string)
    assert TicTacToe.Io.input(io) == input_string
  end

  test "TicTacToe.Io.output/2 returns the string passed in" do
    capture_io(fn ->
      output = TicTacToe.Io.output(:stdio, "the quick brown fox")
      send(self(), output)
    end)

    assert_received("the quick brown fox")
  end
end
