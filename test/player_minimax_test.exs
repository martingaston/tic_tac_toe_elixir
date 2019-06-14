defmodule PlayerMinimaxTest do
  use ExUnit.Case

  test "returns :error if game is over" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(2, "X")
      |> GameState.new(:human_vs_minimax)

    assert PlayerMinimax.move(game_state) == :error
  end

  test "move plays for a horizontal win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> GameState.new(:human_vs_minimax)

    assert PlayerMinimax.move(game_state) == 2
  end

  test "move plays for a vertical win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(3, "X")
      |> GameState.new(:human_vs_minimax)

    assert PlayerMinimax.move(game_state) == 6
  end

  test "move plays for a diagonal win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(4, "X")
      |> GameState.new(:human_vs_minimax)

    assert PlayerMinimax.move(game_state) == 8
  end

  test "move blocks opponent from a win" do
    game_state =
      Board.new()
      |> Board.update(6, "O")
      |> Board.update(8, "O")
      |> GameState.new(:human_vs_minimax)

    assert PlayerMinimax.move(game_state) == 7
  end

  test "move plays for closest win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(8, "X")
      |> GameState.new(:human_vs_minimax)

    assert PlayerMinimax.move(game_state) == 2
  end
end
