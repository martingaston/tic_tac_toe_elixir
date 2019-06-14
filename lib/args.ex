defmodule Args do
  @enforce_keys [:board, :board_manager, :ui, :out, :in, :players]
  defstruct [:board_manager, :board, :ui, :in, :out, :players]
  @player_cross "X"
  @player_nought "O"

  def new(mode, device \\ :stdio) do
    %Args{
      board_manager: Board,
      board: Board.new(),
      ui: UI,
      in: fn -> TicTacToe.Io.get_position(device) end,
      out: fn message -> TicTacToe.Io.output(device, message) end,
      players: Enum.zip([@player_cross, @player_nought], TicTacToe.Players.create(mode))
    }
  end
end
