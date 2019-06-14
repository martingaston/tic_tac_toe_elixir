defmodule PlayerMinimax do
  alias TicTacToe.Players, as: Players

  def move(%GameState{} = game, _message \\ "") do
    Minimax.new(
      game,
      Players.current_mark(game.players),
      Players.opponent_mark(game.players)
    )
    |> Minimax.best_position()
  end
end
