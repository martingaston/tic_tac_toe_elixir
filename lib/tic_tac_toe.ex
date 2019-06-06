defmodule TicTacToe do
  @moduledoc """
  Documentation for TicTacToe.
  """
  @player_cross "X"
  @player_nought "O"

  def start(%{
        board: board,
        player_cross: player_cross,
        player_nought: player_nought,
        ui: ui,
        io: io
      }) do
    game_board = board.new()
    intro(ui, io)

    tick(%{
      current_player: player_cross,
      player_cross: player_cross,
      player_nought: player_nought,
      mark: @player_cross,
      board: board,
      game_board: game_board,
      io: io,
      ui: ui
    })
  end

  defp tick(%{
         current_player: current_player,
         player_cross: player_cross,
         player_nought: player_nought,
         mark: mark,
         board: board,
         game_board: game_board,
         io: io,
         ui: ui
       }) do
    print_board(game_board, ui)
    ui.print_turn(mark)
    pos = current_player.move(game_board, "", %{board: board, ui: ui, io: io})

    updated_board = board.update(game_board, pos, mark)

    board.status(updated_board)
    |> case do
      :won ->
        game_over(:won, %{game_board: updated_board, ui: ui, mark: mark})

      :drawn ->
        game_over(:drawn, %{game_board: updated_board, ui: ui})

      :active ->
        tick(%{
          current_player: swap_player(mark, player_cross, player_nought),
          player_cross: player_cross,
          player_nought: player_nought,
          mark: swap_mark(mark),
          board: board,
          game_board: updated_board,
          io: io,
          ui: ui
        })
    end
  end

  defp game_over(:drawn, %{game_board: game_board, ui: ui}) do
    print_board(game_board, ui)
    ui.print_draw()
  end

  defp game_over(:won, %{game_board: game_board, ui: ui, mark: mark}) do
    print_board(game_board, ui)
    ui.print_winner(mark)
  end

  defp swap_player(mark, player_cross, player_nought) do
    case mark do
      @player_cross -> player_nought
      @player_nought -> player_cross
    end
  end

  defp swap_mark(mark) do
    case mark do
      @player_cross -> @player_nought
      @player_nought -> @player_cross
    end
  end

  defp intro(ui, io) do
    out(ui.message(:title), io)
    out(ui.message(:intro), io)
  end

  defp print_board(board, ui) do
    ui.print_board(board)
  end

  defp out(message, io) do
    io.output(:stdio, message)
  end
end
