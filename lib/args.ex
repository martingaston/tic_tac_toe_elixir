defmodule DisplayState do
  defstruct [:io, :device, :ui, :in, :out]

  def new(io, ui, device) do
    %DisplayState{
      ui: ui,
      in: fn -> io.get_position(device) end,
      out: fn message -> io.output(device, message) end
    }
  end
end

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

defmodule Args do
  defstruct [:game, :display]

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
