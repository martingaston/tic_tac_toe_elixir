defmodule PlayerHuman do
  @first_square 0
  @last_square 8
  def move(board, message, args, io \\ :stdio) do
    args.io.output(io, message)
    position = args.io.get_position(io)

    case valid_move?(position, board, args) do
      {:ok, _} -> position
      {:error, message} -> move(board, args.ui.message(message), args)
    end
  end

  def valid_move?(position, _board, _args) when not is_integer(position) do
    {:error, :nan}
  end

  def valid_move?(position, _board, _args)
      when @first_square or position > @last_square do
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
