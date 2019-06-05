defmodule PlayerHumanTest do
  use ExUnit.Case
  @board Board.new()
  @args %{board: Board}

  test "can place a move on an empty board" do
    position = 1
    board = Board.new()
    assert PlayerHuman.valid_move?(position, board, @args) == {:ok, 1}
  end

  test "returns :error if move is already taken" do
    position = 2
    board = Board.update(@board, position, "X")
    assert PlayerHuman.valid_move?(position, board, @args) == {:error, :occupied}
  end

  test "returns {:error, :out_of_bounds} if position does not exist on board" do
    position = 25
    assert PlayerHuman.valid_move?(position, @board, @args) == {:error, :out_of_bounds}
  end

  test "returns {:error, :nan} if requested position is not an integer" do
    position = "cat"
    assert PlayerHuman.valid_move?(position, @board, @args) == {:error, :nan}
  end
end
