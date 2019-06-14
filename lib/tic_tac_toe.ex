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

  defp next(:active, %Args{game: game} = args) do
    [args.ui.draw_board(game.board), args.ui.player_turn(Players.current_mark(game.players))]
    |> args.out.()

    pos = Players.current_player(game.players).move(args)

    updated_board = Board.update(game.board, pos, Players.current_mark(game.players))

    Board.status(updated_board)
    |> case do
      :won ->
        next(:won, Args.update_board(args, updated_board))

      :drawn ->
        next(:drawn, Args.update_board(args, updated_board))

      :active ->
        next(:active, Args.update_board(args, updated_board) |> Args.update_players())
    end
  end

  defp next(:drawn, %Args{game: game} = args) do
    [args.ui.draw_board(game.board), args.ui.draw()]
    |> args.out.()

    :drawn
  end

  defp next(:won, %Args{game: game} = args) do
    mark = Players.current_mark(game.players)

    [args.ui.draw_board(game.board), args.ui.winner(mark)]
    |> args.out.()

    :won
  end
end
