defmodule PlayerMinimax do
  @winning_score 10
  @losing_score -10
  @draw_score 0

  def move(board, message, args, io \\ :stdio) do
    case Board.status(board) do
      :active -> minimax(board, :active, :maximising_player).position
      _ -> :error
    end
  end

  def minimax(board, mark, next_player, reducer) do
    {:ok, _, available} = Board.moves?(board)

    Enum.map(available, fn square ->
      updated = Board.update(board, square, mark)
      status = Board.status(updated)
      %{position: square, score: minimax(updated, status, next_player).score}
    end)
    |> reducer.(fn %{score: score} -> score end, fn -> raise(Enum.EmptyError) end)
  end

  def minimax(board, :active, :maximising_player) do
    minimax(board, "X", :minimising_player, &Enum.max_by/3)
  end

  def minimax(board, :active, :minimising_player) do
    minimax(board, "O", :maximising_player, &Enum.min_by/3)
  end

  def minimax(board, :won, :maximising_player) do
    {:ok, moves, _} = Board.moves?(board)
    %{score: @losing_score - moves}
  end

  def minimax(board, :won, :minimising_player) do
    {:ok, moves, _} = Board.moves?(board)
    %{score: @winning_score + moves}
  end

  def minimax(_, :drawn, _), do: %{score: @draw_score}
end
