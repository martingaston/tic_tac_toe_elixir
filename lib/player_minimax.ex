defmodule PlayerMinimax do
  alias TicTacToe.Players, as: Players

  def move(args, _message \\ "") do
    Minimax.new(
      args,
      Players.current_mark(args.players),
      Players.opponent_mark(args.players)
    )
    |> Minimax.best_position()
  end
end
