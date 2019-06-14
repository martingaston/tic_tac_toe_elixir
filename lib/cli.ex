defmodule TicTacToe.CLI do
  @moduledoc """
  A two-player version of Tic Tac Toe running over the command line:

  ./tic_tac_toe
  """
  @player_cross "X"
  @player_nought "O"

  def main(_) do
    args = %Game{
      board_manager: Board,
      board: Board.new(),
      ui: UI,
      io: TicTacToe.Io,
      device: :stdio,
      out: nil,
      players:
        Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(:human_vs_human))
    }

    TicTacToe.start(args)
  end
end
