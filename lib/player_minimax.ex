defmodule PlayerMinimax do
  alias TicTacToe.Players, as: Players

  def move(%Args{game: game} = args, _message \\ "") do
    Minimax.new(
      args,
      Players.current_mark(game.players),
      Players.opponent_mark(game.players)
    )
    |> Minimax.best_position()
  end
end
