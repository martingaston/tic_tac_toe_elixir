defmodule TicTacToe.CLI do
  @moduledoc """
  A two-player version of Tic Tac Toe running over the command line:

  ./tic_tac_toe
  """
  @device :stdio
  def main(_) do
    args = Args.new(:human_vs_human, @device)
    TicTacToe.start(args)
  end
end
