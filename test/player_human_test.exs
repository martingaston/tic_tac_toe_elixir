defmodule PlayerHumanTest do
  use ExUnit.Case

  test "can place a move on an empty board" do
    position = 1
    board = %{0 => nil, 1 => nil}
    assert PlayerHuman.valid_move?(position, board) == {:ok, 1}
  end
end
