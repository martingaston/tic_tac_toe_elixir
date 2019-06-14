defmodule PlayerHumanTest do
  use ExUnit.Case
  @player_cross "X"
  @player_nought "O"
  @args %Game{
    board_manager: Board,
    board: Board.new(),
    ui: UI,
    out: nil,
    in: nil,
    players: Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(:human_vs_human))
  }

  test "move/4 can get a valid move from the user and return the zero-indexed integer" do
    {:ok, io} = StringIO.open("1")
    input = fn -> TicTacToe.Io.get_position(io) end
    out = fn message -> TicTacToe.Io.output(io, message) end

    assert PlayerHuman.move(%Game{@args | in: input, out: out}) == 0
  end

  test "move/4 will prompt again if user does not submit valid move" do
    {:ok, io} = StringIO.open("cat\n1")
    input = fn -> TicTacToe.Io.get_position(io) end
    out = fn message -> TicTacToe.Io.output(io, message) end

    assert PlayerHuman.move(%Game{@args | in: input, out: out}) == 0
  end

  test "valid_move?/3 returns :ok when placing valid move on an empty board" do
    position = 1
    assert PlayerHuman.valid_move?(position, @args) == {:ok, 1}
  end

  test "valid_move?/3 returns {:error, :occupied} if move is already taken" do
    position = 2
    {mark, _} = List.first(@args.players)
    updated_args = %Game{@args | board: Board.update(@args.board, position, mark)}
    assert PlayerHuman.valid_move?(position, updated_args) == {:error, :occupied}
  end

  test "valid_move?/3 returns {:error, :out_of_bounds} if number too big/small" do
    position = 25
    assert PlayerHuman.valid_move?(position, @args) == {:error, :out_of_bounds}
  end

  test "valid_move?/3 returns {:error, :nan} if position is not an integer" do
    position = "cat"
    assert PlayerHuman.valid_move?(position, @args) == {:error, :nan}
  end
end
