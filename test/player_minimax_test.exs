defmodule PlayerMinimaxTest do
  use ExUnit.Case
  @player_cross "X"
  @player_nought "O"

  test "returns :error if game is over" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(2, "X")

    assert PlayerMinimax.move(game_state, @player_cross, @player_nought) == :error
  end

  test "move plays for a horizontal win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")

    assert PlayerMinimax.move(game_state, @player_cross, @player_nought) == 2
  end

  test "move plays for a vertical win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(3, "X")

    assert PlayerMinimax.move(game_state, @player_cross, @player_nought) == 6
  end

  test "move plays for a diagonal win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(4, "X")

    assert PlayerMinimax.move(game_state, @player_cross, @player_nought) == 8
  end

  test "move blocks opponent from a win" do
    game_state =
      Board.new()
      |> Board.update(6, "O")
      |> Board.update(8, "O")

    assert PlayerMinimax.move(game_state, @player_cross, @player_nought) == 7
  end

  test "move plays for closest win" do
    game_state =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "X")
      |> Board.update(8, "X")

    assert PlayerMinimax.move(game_state, @player_cross, @player_nought) == 2
  end
end
