defmodule PlayerMinimax do
  def move(board, _message, args, _io \\ :stdio) do
    # TODO I do not think mangaging dependencies like this is quite right - I'm leaning towards making a struct with required fields.
    args = %{
      board: board,
      players: %{
        # TODO the args.player and args.opponent is currently a bit of a hack so we can rush to green
        maximising_player: args.player,
        minimising_player: args.opponent
      }
    }

    case Board.status(board) do
      :active -> Minimax.minimax(args, :active, :maximising_player).position
      _ -> :error
    end
  end
end
