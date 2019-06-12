defmodule UI do
  def print_board_string(board) do
    [
      header(),
      row(board, 0..2),
      header(),
      row(board, 3..5),
      header(),
      row(board, 6..8),
      header(),
      ""
    ]
    |> Enum.join("\n")
  end

  def print_board(state, io \\ :stdio) do
    out(print_board_string(state), io)
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
        "TIC TAC TOE\n"

      :intro ->
        "Turn friends into enemies by succeeding in placing a complete line in any horizontal, vertical or diagonal direction\n"

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

  def print_winner(mark, io \\ :stdio) do
    out("Player #{mark} wins!\n", io)
  end

  def print_turn(mark, io \\ :stdio) do
    out("Player #{mark}'s turn:\n", io)
  end

  def print_draw(io \\ :stdio) do
    out("It's a draw!\n", io)
  end

  def print_instructions(io \\ :stdio) do
    out("Input numbers between 1-9 on alternative turns to place your mark in the 3x3 grid.", io)
  end

  defp out(contents, io) do
    IO.write(io, contents)
  end

  defp fade(text) do
    grey = 242
    IO.ANSI.color(grey) <> text <> IO.ANSI.reset()
  end

  defp humanise(position) do
    Integer.to_string(position + 1)
  end
end
