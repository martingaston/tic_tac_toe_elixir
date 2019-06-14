defmodule TicTacToe do
  alias TicTacToe.Players, as: Players

  @moduledoc """
  Documentation for TicTacToe.
  """

  def start(args) do
    [args.ui.message(:title), args.ui.message(:intro)]
    |> args.out.()

    next(:active, args)
  end

  defp next(:active, args) do
    [args.ui.draw_board(args.board), args.ui.player_turn(Players.current_mark(args.players))]
    |> args.out.()

    pos = Players.current_player(args.players).move(args)

    updated_board = args.board_manager.update(args.board, pos, Players.current_mark(args.players))

    args.board_manager.status(updated_board)
    |> case do
      :won ->
        next(:won, %{args | board: updated_board})

      :drawn ->
        next(:drawn, %{args | board: updated_board})

      :active ->
        next(:active, %{
          args
          | board: updated_board,
            players: Players.next_turn(args.players)
        })
    end
  end

  defp next(:drawn, args) do
    [args.ui.draw_board(args.board), args.ui.draw()]
    |> args.out.()

    :drawn
  end

  defp next(:won, args) do
    mark = Players.current_mark(args.players)

    [args.ui.draw_board(args.board), args.ui.winner(mark)]
    |> args.out.()

    :won
  end
end
