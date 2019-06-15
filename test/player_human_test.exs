defmodule PlayerHumanTest do
  use ExUnit.Case

  test "move/4 can get a valid move from the user and return the zero-indexed integer" do
    {:ok, io} = StringIO.open("1")
    display = DisplayState.new(TicTacToe.Io, UI, io)
    board = Board.new()
    assert PlayerHuman.move(display, board) == 0
  end

  test "move/4 will prompt again if user does not submit valid move" do
    {:ok, io} = StringIO.open("cat\n1")
    display = DisplayState.new(TicTacToe.Io, UI, io)
    board = Board.new()

    assert PlayerHuman.move(display, board) == 0
  end

  test "valid_move?/3 returns :ok when placing valid move on an empty board" do
    position = 1
    args = Args.new(:human_vs_human)
    assert PlayerHuman.valid_move?(position, args) == {:ok, 1}
  end

  test "valid_move?/3 returns {:error, :occupied} if move is already taken" do
    position = 1

    board =
      Board.new()
      |> Board.update(position, "x")

    assert PlayerHuman.valid_move?(position, board) == {:error, :occupied}
  end

  test "valid_move?/3 returns {:error, :out_of_bounds} if number too big/small" do
    position = 25
    board = Board.new()
    assert PlayerHuman.valid_move?(position, board) == {:error, :out_of_bounds}
  end

  test "valid_move?/3 returns {:error, :nan} if position is not an integer" do
    board = Board.new()
    position = "cat"
    assert PlayerHuman.valid_move?(position, board) == {:error, :nan}
  end
end
