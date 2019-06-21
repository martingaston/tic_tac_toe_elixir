defmodule TicTacToe.CLI do
  @moduledoc """
  A two-player version of Tic Tac Toe running over the command line:

  ./tic_tac_toe
  """
  @device :stdio
  def main(_) do
    display = DisplayState.new(TicTacToe.Io, UI, @device)
    {mode, board_size} = setup(display)
    game = GameState.new(mode, board_size, display)
    args = Args.new_from_state(game, display)

    TicTacToe.start(args)
  end

  defp setup(display) do
    mode = Menu.get_mode(display)
    board_size = get_board_size(mode, display)

    {mode, board_size}
  end

  defp get_board_size(:human_vs_human, display), do: Menu.get_board_size(display)
  defp get_board_size(_, _), do: :three_by_three
end
