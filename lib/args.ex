defmodule Args do
  defstruct [:game, :display]

  def build(%GameState{} = game, %DisplayState{} = display) do
    %Args{
      game: game,
      display: display
    }
  end

  def new(mode, device \\ :stdio) do
    display = DisplayState.new(TicTacToe.Io, UI, device)

    %Args{
      game: GameState.new(mode, display),
      display: display
    }
  end

  def update_board(args, new_board) do
    %Args{args | game: GameState.update_board(args.game, new_board)}
  end

  def update_players(args) do
    %Args{args | game: GameState.update_players(args.game)}
  end
end
