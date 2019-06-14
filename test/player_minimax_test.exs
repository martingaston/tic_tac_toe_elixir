defmodule PlayerMinimaxTest do
  use ExUnit.Case
  @minimax PlayerMinimax.new("X", "O")

  test "returns :error if game is over" do
    board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(2, "X")

    assert PlayerMinimax.move(@minimax, board) == :error
  end

  test "move plays for a horizontal win" do
    board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")

    assert PlayerMinimax.move(@minimax, board) == 2
  end

  test "move plays for a vertical win" do
    board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(3, "X")

    assert PlayerMinimax.move(@minimax, board) == 6
  end

  test "move plays for a diagonal win" do
    board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(4, "X")

    assert PlayerMinimax.move(@minimax, board) == 8
  end

  test "move blocks opponent from a win" do
    board =
      Board.new()
      |> Board.update(6, "O")
      |> Board.update(8, "O")

    assert PlayerMinimax.move(@minimax, board) == 7
  end

  test "move plays for closest win" do
    board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(8, "X")

    assert PlayerMinimax.move(@minimax, board) == 2
  end
end
