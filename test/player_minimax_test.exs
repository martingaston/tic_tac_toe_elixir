defmodule PlayerMinimaxTest do
  use ExUnit.Case

  test "returns :error if game is over" do
    state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(2, "X")

    assert PlayerMinimax.move(state, "", %{}) == :error
  end

  test "move plays for a horizontal win" do
    board = Board.new()

    args = %{
      board: board
    }

    state =
      board
      |> Board.update(0, "X")
      |> Board.update(1, "X")

    assert PlayerMinimax.move(state, "", args) == 2
  end

  test "move plays for a vertical win" do
    board = Board.new()

    args = %{
      board: board
    }

    state =
      board
      |> Board.update(0, "X")
      |> Board.update(3, "X")

    assert PlayerMinimax.move(state, "", args) == 6
  end

  test "move plays for a diagonal win" do
    board = Board.new()

    args = %{
      board: board
    }

    state =
      board
      |> Board.update(0, "X")
      |> Board.update(4, "X")

    assert PlayerMinimax.move(state, "", args) == 8
  end

  test "move blocks opponent from a win" do
    board = Board.new()

    args = %{
      board: board
    }

    state =
      board
      |> Board.update(6, "O")
      |> Board.update(8, "O")

    assert PlayerMinimax.move(state, "", args) == 7
  end

  test "move plays for closest win" do
    board = Board.new()

    args = %{
      board: board
    }

    state =
      board
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(8, "X")

    assert PlayerMinimax.move(state, "", args) == 2
  end
end
