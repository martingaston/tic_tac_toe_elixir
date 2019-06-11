defmodule PlayerMinimax do
  @winning_score 10
  @losing_score -10
  @draw_score 0

  def move(board, _message, _args, _io \\ :stdio) do
    case Board.status(board) do
      :active -> minimax(board, :active, :maximising_player).position
      _ -> :error
    end
  end

  # the function signature is different enough to warrant a new fn 
  def traverse(board, mark, next_player, reducer) do
    Board.available(board)
    |> Enum.map(fn square ->
      # can these be piped at all? this feels rather imperative
      updated = Board.update(board, square, mark)
      status = Board.status(updated)
      %{position: square, score: minimax(updated, status, next_player).score}
    end)
    |> reducer.(fn %{score: score} -> score end, fn -> raise(Enum.EmptyError) end)
  end

  def minimax(board, :active, :maximising_player) do
    traverse(board, "X", :minimising_player, &Enum.max_by/3)
  end

  def minimax(board, :active, :minimising_player) do
    traverse(board, "O", :maximising_player, &Enum.min_by/3)
  end

  def minimax(board, :won, :maximising_player) do
    %{score: @losing_score - Board.moves?(board)}
  end

  def minimax(board, :won, :minimising_player) do
    %{score: @winning_score + Board.moves?(board)}
  end

  def minimax(_, :drawn, _), do: %{score: @draw_score}
end
