defmodule PlayerMinimax do
  def move(board, _message, args, _io \\ :stdio) do
    # TODO I do not think mangaging dependencies like this is quite right - I'm leaning towards making a struct with required fields.
    case Board.status(board) do
      :active ->
        Minimax.new(board, args.player, args.opponent)
        |> Minimax.best_position()

      _ ->
        :error
    end
  end
end
