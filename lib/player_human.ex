defmodule PlayerHuman do
  defstruct [:display, :message]
  @first_square 0
  @last_square 8

  def new(%DisplayState{} = display, message \\ "") do
    %PlayerHuman{display: display, message: message}
  end

  def move(%DisplayState{} = display, board, message \\ "") do
    display.out.(message)

    display.in.()
    |> valid_move?(board)
    |> case do
      {:ok, position} -> position
      {:error, message} -> move(display, message)
    end
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
