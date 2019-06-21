defmodule TicTacToe do
  alias TicTacToe.{Players, Player}

  @moduledoc """
  Documentation for TicTacToe.
  """

  def start(%Args{display: display} = args) do
    [display.ui.message(:title), display.ui.message(:intro)]
    |> display.out.()

    next_turn(args)
  end

  defp next_turn(%Args{game: game, display: display} = args) do
    [
      display.ui.draw_board(game.board),
      display.ui.player_turn(Players.current_mark(game.players))
    ]
    |> display.out.()

    position =
      Players.current_player(game.players)
      |> Player.choose_move(game.board)

    updated_board = Board.update(game.board, position, Players.current_mark(game.players))

    Board.status(updated_board)
    |> case do
      :won ->
        won(Args.update_board(args, updated_board))

      :drawn ->
        drawn(Args.update_board(args, updated_board))

      :active ->
        next_turn(Args.update_board(args, updated_board) |> Args.update_players())
    end
  end

  defp drawn(%Args{game: game, display: display}) do
    [display.ui.draw_board(game.board), display.ui.draw()]
    |> display.out.()

    :drawn
  end

  defp won(%Args{game: game, display: display}) do
    mark = Players.current_mark(game.players)

    [display.ui.draw_board(game.board), display.ui.winner(mark)]
    |> display.out.()

    :won
  end
end
