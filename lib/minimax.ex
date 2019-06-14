defmodule Minimax do
  @winning_score 10
  @losing_score -10
  @draw_score 0

  defstruct [:board, :status, :players]

  def new(args, maximising_player_mark, minimising_player_mark) do
    %Minimax{
      board: args.board,
      status: Board.status(args.board),
      players: %{
        maximising_player: maximising_player_mark,
        minimising_player: minimising_player_mark
      }
    }
  end

  def best_position(args) do
    case args.status do
      :active -> minimax(args, :active, :maximising_player).position
      _ -> :error
    end
  end

  defp minimax(args, :active, :maximising_player) do
    traverse(args, :minimising_player)
  end

  defp minimax(args, :active, :minimising_player) do
    traverse(args, :maximising_player)
  end

  defp minimax(args, :won, :maximising_player) do
    %{score: @losing_score - Board.moves?(args.board)}
  end

  defp minimax(args, :won, :minimising_player) do
    %{score: @winning_score + Board.moves?(args.board)}
  end

  defp minimax(_, :drawn, _), do: %{score: @draw_score}

  defp traverse(args, next_player) do
    Board.available_positions(args.board)
    |> Enum.map(fn square ->
      args
      |> update_move(square, next_player)
      |> score_position(square, next_player)
    end)
    |> optimal(next_player)
  end

  defp optimal(scores, :maximising_player),
    do: Enum.min_by(scores, fn %{score: score} -> score end)

  defp optimal(scores, :minimising_player),
    do: Enum.max_by(scores, fn %{score: score} -> score end)

  defp mark(%{players: %{minimising_player: mark}}, :maximising_player), do: mark
  defp mark(%{players: %{maximising_player: mark}}, :minimising_player), do: mark

  defp update_move(args, position, next_player),
    do: args |> update_board(position, next_player) |> update_status()

  defp update_board(args, position, next_player),
    do: %{args | board: Board.update(args.board, position, mark(args, next_player))}

  defp update_status(args), do: %{args | status: Board.status(args.board)}

  defp score_position(args, position, next_player),
    do: %{position: position, score: minimax(args, args.status, next_player).score}
end
