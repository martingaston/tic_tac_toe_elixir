defmodule TicTacToe do
  @moduledoc """
  Documentation for TicTacToe.
  """

  def start(%{board: board}) do
    game_board = board.new()
    game_board
  end
end
