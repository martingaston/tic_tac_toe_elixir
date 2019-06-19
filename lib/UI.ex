defmodule UI do
  def draw_board_dynamic(board) do
    zero_indexed_size = Board.size(board) - 1

    Enum.chunk_every(0..zero_indexed_size, Board.side_length(board))
    |> Enum.map(fn x -> row(board, x) end)
    |> Enum.join("\n" <> header() <> "\n")
  end

  def draw_board(board) do
    [
      header(),
      draw_board_dynamic(board),
      header(),
      ""
    ]
    |> Enum.join("\n")
  end

  defp header(), do: "+-----------+"

  defp row(board, range) do
    Enum.reduce(range, "", fn pos, acc -> acc <> square(board, pos) end) <> "|"
  end

  defp square(board, position) do
    square =
      Board.get(board, position)
      |> case do
        "" -> humanise(position) |> fade()
        mark -> mark
      end

    "| #{square} "
  end

  def message(key) do
    case key do
      :title ->
        "TIC TAC TOE"

      :intro ->
        "Turn friends into enemies by succeeding in placing a complete line in any horizontal, vertical or diagonal direction"

      :nan ->
        "Sorry, that's not a valid number. Please enter a whole number."

      :out_of_bounds ->
        "Sorry, that number isn't available on the board."

      :occupied ->
        "Sorry, that square has been taken. Please enter an unoccupied square."

      _ ->
        "Uh-oh, something went wrong!"
    end
  end

  def winner(mark) do
    "Player #{mark} wins!"
  end

  def player_turn(mark) do
    "Player #{mark}'s turn: "
  end

  def draw() do
    "It's a draw!"
  end

  def instructions() do
    "Input numbers between 1-9 on alternative turns to place your mark in the 3x3 grid."
  end

  defp fade(text) do
    grey = 242
    IO.ANSI.color(grey) <> text <> IO.ANSI.reset()
  end

  defp humanise(position) do
    Integer.to_string(position + 1)
  end
end
