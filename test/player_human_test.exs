defmodule PlayerHumanTest do
  use ExUnit.Case

  test "move/4 can get a valid move from the user and return the zero-indexed integer" do
    {:ok, io} = StringIO.open("1")
    args = Game.new(:human_vs_human, io)
    assert PlayerHuman.move(args) == 0
  end

  test "move/4 will prompt again if user does not submit valid move" do
    {:ok, io} = StringIO.open("cat\n1")
    args = Game.new(:human_vs_human, io)

    assert PlayerHuman.move(args) == 0
  end

  test "valid_move?/3 returns :ok when placing valid move on an empty board" do
    position = 1
    args = Game.new(:human_vs_human)
    assert PlayerHuman.valid_move?(position, args) == {:ok, 1}
  end

  test "valid_move?/3 returns {:error, :occupied} if move is already taken" do
    args = Game.new(:human_vs_human)
    position = 2
    {mark, _} = List.first(args.players)
    updated_args = %Game{args | board: args.board_manager.update(args.board, position, mark)}
    assert PlayerHuman.valid_move?(position, updated_args) == {:error, :occupied}
  end

  test "valid_move?/3 returns {:error, :out_of_bounds} if number too big/small" do
    args = Game.new(:human_vs_human)
    position = 25
    assert PlayerHuman.valid_move?(position, args) == {:error, :out_of_bounds}
  end

  test "valid_move?/3 returns {:error, :nan} if position is not an integer" do
    args = Game.new(:human_vs_human)
    position = "cat"
    assert PlayerHuman.valid_move?(position, args) == {:error, :nan}
  end
end
