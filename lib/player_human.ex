defmodule PlayerHuman do
  @first_square 0
  @last_square 8
  defstruct [:in, :out, :ui]

  def new(%DisplayState{in: input, out: output, ui: ui}) do
    %PlayerHuman{in: input, out: output, ui: ui}
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
  def choose_move(%PlayerHuman{in: input} = player, board) do
    input.()
    |> coerce_int()
    |> PlayerHuman.valid_move?(board)
    |> case do
      {:ok, position} -> position
      {:error, message} -> error(player, message) |> choose_move(board)
    end
  end

  defp error(%PlayerHuman{ui: ui, out: out} = player, message) do
    ui.message(message)
    |> out.()

    player
  end

  defp zero_index(int), do: int - 1

  defp coerce_int(string) do
    string
    |> Integer.parse()
    |> case do
      {int, _} -> int |> zero_index()
      _ -> string
    end
  end
end
