defmodule PlayerHuman do
  @first_square 0
  @last_square 8
  def move(args, message \\ "") do
    args.out.(message)

    args.io.get_position(args.device)
    |> valid_move?(args)
    |> case do
      {:ok, position} -> position
      {:error, message} -> move(args, message)
    end
  end

  def valid_move?(position, _args) when not is_integer(position) do
    {:error, :nan}
  end

  def valid_move?(position, _args)
      when position < @first_square or position > @last_square do
    {:error, :out_of_bounds}
  end

  def valid_move?(position, args) do
    if args.board_manager.available?(args.board, position) do
      {:ok, position}
    else
      {:error, :occupied}
    end
  end
end
