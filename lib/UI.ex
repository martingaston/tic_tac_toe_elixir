defmodule UI do
  def draw_board(board) do
    zero_indexed_size = Board.size(board) - 1
    side_length = Board.side_length(board)

    calculate_board_rows(zero_indexed_size, side_length)
    |> generate_rows(board)
    |> generate_dividers(side_length)
    |> add_header_and_footer(side_length)
  end

  defp calculate_board_rows(size, side_length) do
    Enum.chunk_every(0..size, side_length)
  end

  defp generate_rows(board_list, board), do: Enum.map(board_list, &row(board, &1))

  defp generate_dividers(board_list, side_length) do
    Enum.join(board_list, "\n" <> divider(side_length) <> "\n")
  end

  defp add_header_and_footer(board_string, side_length) do
    "#{divider(side_length)}\n#{board_string}\n#{divider(side_length)}\n"
  end

  defp divider(side_length) do
    square_width = 4
    final_border_width = 1
    edges_total = 2
    width = square_width * side_length + final_border_width - edges_total
    "+" <> Enum.reduce(1..width, "", fn _, acc -> acc <> "-" end) <> "+"
  end

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
