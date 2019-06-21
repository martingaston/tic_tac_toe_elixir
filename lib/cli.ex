defmodule TicTacToe.CLI do
  @moduledoc """
  A two-player version of Tic Tac Toe running over the command line:

  ./tic_tac_toe
  """
  @device :stdio
  def main(_) do
    display = DisplayState.new(TicTacToe.Io, UI, @device)
    mode = Menu.get_mode(display)

    board_size =
      if mode == :human_vs_human do
        Menu.get_board_size(display)
      else
        :three_by_three
      end

    game = GameState.new(mode, board_size, display)
    args = Args.build(game, display)
    TicTacToe.start(args)
  end
end
