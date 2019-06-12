defmodule TicTacToe do
  @moduledoc """
  Documentation for TicTacToe.
  """
  @player_cross "X"
  @player_nought "O"

  def start(
        %{
          board: board,
          players: players,
          ui: ui,
          io: io
        },
        device \\ :stdio
      ) do
    out = fn message -> io.output(device, message) end
    game_board = board.new()
    players = Enum.zip([@player_cross, @player_nought], players)
    out.(ui.message(:title))
    out.(ui.message(:intro))

    tick(:active, players, %{
      board: board,
      game_board: game_board,
      out: out,
      io: io,
      device: device,
      ui: ui
    })
  end

  defp tick(:active, players, %{
         board: board,
         game_board: game_board,
         ui: ui,
         io: io,
         device: device,
         out: out
       }) do
    {current_mark, current_player} = List.first(players)
    {opponent_mark, _} = List.last(players)
    out.(ui.draw_board(game_board))
    out.(ui.player_turn(current_mark))

    pos =
      current_player.move(
        game_board,
        "",
        %{board: board, player: current_mark, opponent: opponent_mark, ui: ui, io: io},
        device
      )

    updated_board = board.update(game_board, pos, current_mark)

    board.status(updated_board)
    |> case do
      :won ->
        tick(:won, %{
          game_board: updated_board,
          io: io,
          device: device,
          ui: ui,
          out: out,
          mark: current_mark
        })

      :drawn ->
        tick(:drawn, %{game_board: updated_board, out: out, ui: ui})

      :active ->
        tick(:active, Enum.reverse(players), %{
          board: board,
          game_board: updated_board,
          io: io,
          ui: ui,
          out: out,
          device: device
        })
    end
  end

  defp tick(:drawn, %{game_board: game_board, ui: ui, out: out}) do
    out.(ui.draw_board(game_board))
    out.(ui.draw())
  end

  defp tick(:won, %{game_board: game_board, out: out, ui: ui, mark: mark}) do
    out.(ui.draw_board(game_board))
    out.(ui.winner(mark))
  end
end
