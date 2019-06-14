defmodule TicTacToe.CLI do
  @moduledoc """
  A two-player version of Tic Tac Toe running over the command line:

  ./tic_tac_toe
  """
  @player_cross "X"
  @player_nought "O"
  @device :stdio
  def main(_) do
    args = %Game{
      board_manager: Board,
      board: Board.new(),
      ui: UI,
      in: fn -> TicTacToe.Io.get_position(@device) end,
      out: fn message -> TicTacToe.Io.output(@device, message) end,
      players:
        Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(:human_vs_human))
    }

    TicTacToe.start(args)
  end
end
