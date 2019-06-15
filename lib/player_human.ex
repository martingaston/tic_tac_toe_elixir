defmodule PlayerHuman do
  defstruct [:display, :message]
  @first_square 0
  @last_square 8

  def new(%DisplayState{} = display) do
    %PlayerHuman{display: display}
  end

  def move(%DisplayState{} = display, board) do
    display.in.()
    |> valid_move?(board)
    |> case do
      {:ok, position} -> position
      {:error, message} -> error(display, message) |> move(display)
    end
  end

  def error(display, message) do
    display.out.(message)
    display
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
