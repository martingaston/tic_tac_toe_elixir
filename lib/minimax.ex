defmodule Minimax do
  @winning_score 10
  @losing_score -10
  @draw_score 0

  def minimax(args, :active, :maximising_player) do
    traverse(args, :minimising_player, &Enum.max_by/3)
  end

  def minimax(args, :active, :minimising_player) do
    traverse(args, :maximising_player, &Enum.min_by/3)
  end

  def minimax(args, :won, :maximising_player) do
    %{score: @losing_score - Board.moves?(args.board)}
  end

  def minimax(args, :won, :minimising_player) do
    %{score: @winning_score + Board.moves?(args.board)}
  end

  def minimax(_, :drawn, _), do: %{score: @draw_score}

  def traverse(args, next_player, reducer) do
    # TODO there's got to be a better way of handling this - I like matching on the atom, but maybe we can bind the atom and the mark into a tuple
    mark =
      case next_player do
        :maximising_player -> Map.get(args.players, :minimising_player)
        :minimising_player -> Map.get(args.players, :maximising_player)
      end

    Board.available_positions(args.board)
    |> Enum.map(fn square ->
      # TODO can these be piped at all? this feels rather imperative
      updated = Board.update(args.board, square, mark)
      status = Board.status(updated)
      %{position: square, score: minimax(%{args | board: updated}, status, next_player).score}
    end)
    |> reducer.(fn %{score: score} -> score end, fn -> raise(Enum.EmptyError) end)
  end
end
