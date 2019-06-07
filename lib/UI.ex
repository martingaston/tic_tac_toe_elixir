defmodule UI do
  def print_board(state, io \\ :stdio) do
    print_header(io)
    print_row(state, 0..2, io)
    print_header(io)
    print_row(state, 3..5, io)
    print_header(io)
    print_row(state, 6..8, io)
    print_header(io)
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

  defp print_header(io) do
    out("+-----------+\n", io)
  end

  defp print_row(state, range, io) do
    Enum.each(range, fn pos -> print_square(state, pos, io) end)
    out("|\n", io)
  end

  defp print_square(state, position, io) do
    square =
      Map.get(state, position)
      |> case do
        "" -> humanise(position) |> fade()
        mark -> mark
      end

    out("| #{square} ", io)
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
