defmodule PlayerMinimax do
  @winning_score 10
  @losing_score -10
  @draw_score 0

  def move(board, _message, args, _io \\ :stdio) do
    args = %{
      board: board,
      players: %{
        maximising_player: args.player,
        minimising_player: args.opponent
      }
    }

    case Board.status(board) do
      :active -> minimax(args, :active, :maximising_player).position
      _ -> :error
    end
  end

  def traverse(args, next_player, reducer) do
    mark =
      case next_player do
        :maximising_player -> Map.get(args.players, :minimising_player)
        :minimising_player -> Map.get(args.players, :maximising_player)
      end

    Board.available(args.board)
    |> Enum.map(fn square ->
      # can these be piped at all? this feels rather imperative
      updated = Board.update(args.board, square, mark)
      status = Board.status(updated)
      %{position: square, score: minimax(%{args | board: updated}, status, next_player).score}
    end)
    |> reducer.(fn %{score: score} -> score end, fn -> raise(Enum.EmptyError) end)
  end

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
end
