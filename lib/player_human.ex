defmodule PlayerHuman do
  @first_square 0
  @last_square 8
  defstruct [:display, :message]

  def new(%DisplayState{} = display) do
    %PlayerHuman{display: display}
  end

  def valid_move?(position, _) when not is_integer(position) do
    {:error, :nan}
  end

  def valid_move?(position, _)
      when position < @first_square or position > @last_square do
    {:error, :out_of_bounds}
  end

  def valid_move?(position, board) do
    if Board.available?(board, position) do
      {:ok, position}
    else
      {:error, :occupied}
    end
  end
end

defimpl TicTacToe.Player, for: PlayerHuman do
  def choose_move(%PlayerHuman{display: display} = player, board) do
    display.in.()
    |> PlayerHuman.valid_move?(board)
    |> case do
      {:ok, position} -> position
      {:error, message} -> error(player, message) |> choose_move(board)
    end
  end

  defp error(%PlayerHuman{display: display} = player, message) do
    display.out.(display.ui.message(message))
    player
  end
end
