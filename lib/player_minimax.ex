defmodule PlayerMinimax do
  def move(board, _message, args, _io \\ :stdio) do
    Minimax.new(board, args.player, args.opponent)
    |> Minimax.best_position()
  end
end
