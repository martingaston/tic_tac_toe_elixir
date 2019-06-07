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
    game_board = board.new()
    players = Enum.zip([@player_cross, @player_nought], players)
    out(ui.message(:title), io)
    out(ui.message(:intro), io)

    tick(:active, players, %{
      board: board,
      game_board: game_board,
      io: io,
      ui: ui,
      device: device
    })
  end

  defp tick(:active, players, %{
         board: board,
         game_board: game_board,
         io: io,
         ui: ui,
         device: device
       }) do
    {current_mark, current_player} = List.first(players)
    print_board(game_board, ui)
    ui.print_turn(current_mark)
    pos = current_player.move(game_board, "", %{board: board, ui: ui, io: io}, device)

    updated_board = board.update(game_board, pos, current_mark)

    board.status(updated_board)
    |> case do
      :won ->
        tick(:won, %{game_board: updated_board, ui: ui, mark: current_mark})

      :drawn ->
        tick(:drawn, %{game_board: updated_board, ui: ui})

      :active ->
        tick(:active, Enum.reverse(players), %{
          board: board,
          game_board: updated_board,
          io: io,
          ui: ui,
          device: device
        })
    end
  end

  defp tick(:drawn, %{game_board: game_board, ui: ui}) do
    print_board(game_board, ui)
    ui.print_draw()
  end

  defp tick(:won, %{game_board: game_board, ui: ui, mark: mark}) do
    print_board(game_board, ui)
    ui.print_winner(mark)
  end

  defp print_board(board, ui, device \\ :stdio) do
    ui.print_board(board, device)
  end

  defp out(message, io, device \\ :stdio) do
    io.output(device, message)
  end
end
