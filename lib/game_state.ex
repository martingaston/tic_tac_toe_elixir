defmodule GameState do
  @player_cross "X"
  @player_nought "O"
  defstruct [:board, :players]

  alias TicTacToe.Players

  def new(player_mode, board_size \\ :three_by_three, display) do
    %GameState{
      board: Board.new(board_size),
      players:
        Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(player_mode, display))
    }
  end

  def update_board(game, new_board) do
    %GameState{game | board: new_board}
  end

  def update_players(game) do
    %GameState{game | players: Players.next_turn(game.players)}
  end
end
