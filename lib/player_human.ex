defmodule PlayerHuman do
  def move(position, board, args) do
    case valid_move?(position, board, args) do
      {:ok, move} -> move
      {:error, :message} -> :message
    end
  end

  def valid_move?(position, _board, _args) when not is_integer(position) do
    {:error, :nan}
  end

  def valid_move?(position, _board, _args) when position < 0 or position > 8 do
    {:error, :out_of_bounds}
  end

  def valid_move?(position, board, args) do
    if args.board.available?(board, position) do
      {:ok, position}
    else
      {:error, :occupied}
    end
  end
end
