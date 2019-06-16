defmodule GameState do
  @player_cross "X"
  @player_nought "O"
  defstruct [:board, :players]

  alias TicTacToe.Players

  def new(player_mode, opts) do
    %GameState{
      board: Board.new(),
      players:
        Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(player_mode, opts))
    }
  end

  def update_board(game, new_board) do
    %GameState{game | board: new_board}
  end

  def update_players(game) do
    %GameState{game | players: Players.next_turn(game.players)}
  end
end

