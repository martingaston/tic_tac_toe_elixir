defmodule PlayerMinimax do
  defstruct [:player, :opponent]

  def new(player_mark, opponent_mark),
    do: %PlayerMinimax{player: player_mark, opponent: opponent_mark}

  def move(%PlayerMinimax{player: player, opponent: opponent}, board) do
    Minimax.new(board, player, opponent)
    |> Minimax.best_position()
  end
end
