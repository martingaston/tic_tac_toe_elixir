defmodule PlayerMinimax do
  def move(board, player_mark, opponent_mark) do
    Minimax.new(board, player_mark, opponent_mark)
    |> Minimax.best_position()
  end
end
