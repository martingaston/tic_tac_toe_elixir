defmodule PlayerHuman do
  def move(board, message, args, io \\ :stdio) do
    args.io.output(io, message)
    position = args.io.get_position(io)

    case valid_move?(position, board, args) do
      {:ok, _move} -> args.board.update(board, position, args.mark)
      {:error, message} -> move(board, args.ui.message(message), args)
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
