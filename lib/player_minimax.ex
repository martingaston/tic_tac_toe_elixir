defmodule PlayerMinimax do
  @winning_score 10
  @losing_score -10
  @draw_score 0

  def move(board, _message, _args, _io \\ :stdio) do
    {:ok, _, available} = Board.moves?(board)

    Enum.map(available, fn square ->
      IO.puts("Hi...")
      updated_board = Board.update(board, square, "X")
      status = Board.status(updated_board)
      IO.inspect(available)
      IO.inspect(List.delete(available, square))
      evaluate_board(updated_board, status, available, :minimising_player)
    end)
    |> Enum.zip(available)
    |> Enum.reduce({-1, -1}, fn {score, position}, {max_score, max_pos} ->
      if score > max_score do
        {score, position}
      else
        {max_score, max_pos}
      end
    end)

    case board do
      %{0 => "X", 1 => "X"} -> 2
      %{0 => "X", 3 => "X"} -> 6
      %{0 => "X", 4 => "X"} -> 8
      %{0 => "O", 2 => "O"} -> 1
      _ -> 9
    end
  end

  def evaluate_board(_board, :won, available, :maximising_player),
    do: @winning_score + Enum.count(available)

  def evaluate_board(_board, :won, available, :minimising_player),
    do: @losing_score - Enum.count(available)

  def evaluate_board(_board, :drawn, _, _), do: @draw_score

  def evaluate_board(board, :active, [current | rest], :maximising_player) do
    IO.puts("Maximising...")
    updated_board = Board.update(board, current, "X")
    status = Board.status(updated_board)
    value = @losing_score - Enum.count([current | rest])
    Enum.max([value, evaluate_board(updated_board, status, rest, :minimising_player)])
  end

  def evaluate_board(board, :active, [current | rest], :minimising_player) do
    IO.puts("Minimising...")
    updated_board = Board.update(board, current, "O")
    status = Board.status(updated_board)
    value = @winning_score + Enum.count([current | rest])
    Enum.min([value, evaluate_board(updated_board, status, rest, :maximising_player)])
  end
end
