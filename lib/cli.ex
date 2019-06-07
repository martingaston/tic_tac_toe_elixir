defmodule TicTacToe.CLI do
  @moduledoc """
  A two-player version of Tic Tac Toe running over the command line:

  ./tic_tac_toe
  """

  def main(_) do
    args = %{
      board: Board,
      ui: UI,
      io: TicTacToe.Io,
      players: TicTacToe.Players.create(:human_vs_human)
    }

    TicTacToe.start(args)
  end
end
