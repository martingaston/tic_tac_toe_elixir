defmodule PlayerHumanTest do
  use ExUnit.Case
  @board Board.new()
  @args %{board: Board, io: TicTacToe.Io, ui: UI, mark: "X"}

  test "move/4 can get a valid move from the user" do
    {:ok, io} = StringIO.open("1")
    %{0 => mark} = PlayerHuman.move(@board, "", @args, io)
    assert mark == "X"
  end

  test "move/4 will prompt again if user does not submit valid move " do
    {:ok, io} = StringIO.open("cat\n1")
    %{0 => mark} = PlayerHuman.move(@board, "", @args, io)
    assert mark == "X"
  end

  test "valid_move?/3 returns :ok when placing valid move on an empty board" do
    position = 1
    board = Board.new()
    assert PlayerHuman.valid_move?(position, board, @args) == {:ok, 1}
  end

  test "valid_move?/3 returns {:error, :occupied} if move is already taken" do
    position = 2
    board = Board.update(@board, position, "X")
    assert PlayerHuman.valid_move?(position, board, @args) == {:error, :occupied}
  end

  test "valid_move?/3 returns {:error, :out_of_bounds} if number too big/small" do
    position = 25
    assert PlayerHuman.valid_move?(position, @board, @args) == {:error, :out_of_bounds}
  end

  test "valid_move?/3 returns {:error, :nan} if position is not an integer" do
    position = "cat"
    assert PlayerHuman.valid_move?(position, @board, @args) == {:error, :nan}
  end
end
