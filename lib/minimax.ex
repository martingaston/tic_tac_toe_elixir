defmodule Minimax do
  @winning_score 10
  @losing_score -10
  @draw_score 0

  defstruct [:board, :players]

  def new(board, maximising_player_mark, minimising_player_mark) do
    %Minimax{
      board: board,
      players: %{
        maximising_player: maximising_player_mark,
        minimising_player: minimising_player_mark
      }
    }
  end

  def best_position(args) do
    minimax(args, :active, :maximising_player).position
  end

  defp minimax(args, :active, :maximising_player) do
    traverse(args, :minimising_player, &Enum.max_by/3)
  end

  defp minimax(args, :active, :minimising_player) do
    traverse(args, :maximising_player, &Enum.min_by/3)
  end

  defp minimax(args, :won, :maximising_player) do
    %{score: @losing_score - Board.moves?(args.board)}
  end

  defp minimax(args, :won, :minimising_player) do
    %{score: @winning_score + Board.moves?(args.board)}
  end

  defp minimax(_, :drawn, _), do: %{score: @draw_score}

  defp traverse(args, next_player, reducer) do
    Board.available_positions(args.board)
    |> Enum.map(fn square ->
      # TODO can these be piped at all? this feels rather imperative
      updated = Board.update(args.board, square, mark(args, next_player))
      status = Board.status(updated)
      %{position: square, score: minimax(%{args | board: updated}, status, next_player).score}
    end)
    |> reducer.(fn %{score: score} -> score end, fn -> raise(Enum.EmptyError) end)
  end

  defp mark(%{players: %{minimising_player: mark}}, :maximising_player), do: mark
  defp mark(%{players: %{maximising_player: mark}}, :minimising_player), do: mark
end
