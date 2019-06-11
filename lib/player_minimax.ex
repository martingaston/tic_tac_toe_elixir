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

  def minimax(board, :active, :maximising_player) do
    {:ok, _, available} = Board.moves?(board)

    Enum.map(available, fn square ->
      updated = Board.update(board, square, "X")
      status = Board.status(updated)
      %{position: square, score: score(updated, status, :minimising_player)}
    end)
    |> Enum.max_by(fn %{score: score} -> score end)
  end

  # scores on max/min are reversed as the check takes place before a move is played?
  def score(board, :won, :maximising_player) do
    {:ok, moves, _} = Board.moves?(board)
    @losing_score - moves
  end

  def score(board, :won, :minimising_player) do
    {:ok, moves, _} = Board.moves?(board)
    @winning_score + moves
  end

  def score(_board, :drawn, _), do: @draw_score

  def score(board, :active, :minimising_player) do
    {:ok, _, available} = Board.moves?(board)

    Enum.map(available, fn square ->
      updated = Board.update(board, square, "O")
      status = Board.status(updated)
      score(updated, status, :maximising_player)
    end)
    |> Enum.min()
  end

  def score(board, :active, :maximising_player) do
    {:ok, _, available} = Board.moves?(board)

    Enum.map(available, fn square ->
      updated = Board.update(board, square, "X")
      status = Board.status(updated)
      score(updated, status, :minimising_player)
    end)
    |> Enum.max()
  end
end
