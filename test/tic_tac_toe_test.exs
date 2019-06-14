defmodule TicTacToeTest do
  use ExUnit.Case
  doctest TicTacToe

  @player_cross "X"
  @player_nought "O"

  test "game ends if player cross wins" do
    input_player_cross_win = "1\n7\n2\n8\n3"
    {:ok, device} = StringIO.open(input_player_cross_win)

    args = %Game{
      board: Board.new(),
      board_manager: Board,
      ui: UI,
      in: fn -> TicTacToe.Io.get_position(device) end,
      out: fn message -> TicTacToe.Io.output(device, message) end,
      players:
        Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(:human_vs_human))
    }

    assert TicTacToe.start(args) == :won
  end

  test "game ends if player nought wins" do
    input_player_nought_win = "1\n3\n2\n5\n4\n7"
    {:ok, device} = StringIO.open(input_player_nought_win)

    args = %Game{
      board: Board.new(),
      board_manager: Board,
      ui: UI,
      in: fn -> TicTacToe.Io.get_position(device) end,
      out: fn message -> TicTacToe.Io.output(device, message) end,
      players:
        Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(:human_vs_human))
    }

    assert TicTacToe.start(args) == :won
  end

  test "game ends on draw" do
    input_players_draw = "1\n2\n5\n9\n6\n4\n7\n3\n8"
    {:ok, device} = StringIO.open(input_players_draw)

    args = %Game{
      board: Board.new(),
      board_manager: Board,
      ui: UI,
      in: fn -> TicTacToe.Io.get_position(device) end,
      out: fn message -> TicTacToe.Io.output(device, message) end,
      players:
        Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(:human_vs_human))
    }

    assert TicTacToe.start(args) == :drawn
  end
end
