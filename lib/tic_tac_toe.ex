defmodule TicTacToe do
  @moduledoc """
  Documentation for TicTacToe.
  """

  def start(args) do
    out = fn message -> args.io.output(args.device, message) end

    [args.ui.message(:title), args.ui.message(:intro)]
    |> out.()

    tick(:active, %{args | out: out})
  end

  defp tick(:active, args) do
    {current_mark, current_player} = List.first(args.players)
    {opponent_mark, _} = List.last(args.players)

    [args.ui.draw_board(args.board), args.ui.player_turn(current_mark)]
    |> args.out.()

    pos = current_player.move(args)

    updated_board = args.board_manager.update(args.board, pos, current_mark)

    args.board_manager.status(updated_board)
    |> case do
      :won ->
        tick(:won, %{args | board: updated_board})

      :drawn ->
        tick(:drawn, %{args | board: updated_board})

      :active ->
        tick(:active, %{args | board: updated_board, players: Enum.reverse(args.players)})
    end
  end

  defp tick(:drawn, args) do
    [args.ui.draw_board(args.board), args.ui.draw()]
    |> args.out.()
  end

  defp tick(:won, args) do
    {_, mark} = List.first(args.players)

    [args.ui.draw_board(args.board), args.ui.winner(mark)]
    |> args.out.()
  end
end
