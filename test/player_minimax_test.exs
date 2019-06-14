defmodule PlayerMinimaxTest do
  use ExUnit.Case

  test "returns :error if game is over" do
    updated_board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(2, "X")

    args = Args.new(:human_vs_minimax) |> Args.update_board(updated_board)

    assert PlayerMinimax.move(args) == :error
  end

  test "move plays for a horizontal win" do
    updated_board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")

    args = Args.new(:human_vs_minimax) |> Args.update_board(updated_board)

    assert PlayerMinimax.move(args) == 2
  end

  test "move plays for a vertical win" do
    updated_board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(3, "X")

    args = Args.new(:human_vs_minimax) |> Args.update_board(updated_board)
    assert PlayerMinimax.move(args) == 6
  end

  test "move plays for a diagonal win" do
    updated_board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(4, "X")

    args = Args.new(:human_vs_minimax) |> Args.update_board(updated_board)
    assert PlayerMinimax.move(args) == 8
  end

  test "move blocks opponent from a win" do
    updated_board =
      Board.new()
      |> Board.update(6, "X")
      |> Board.update(8, "X")

    args = Args.new(:human_vs_minimax) |> Args.update_board(updated_board)
    assert PlayerMinimax.move(args) == 7
  end

  test "move plays for closest win" do
    updated_board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(8, "X")

    args = Args.new(:human_vs_minimax) |> Args.update_board(updated_board)
    assert PlayerMinimax.move(args) == 2
  end
end
