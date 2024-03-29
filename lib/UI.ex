defmodule Ui do
  def draw_board(%Board{} = board) do
    board
    |> calculate_board_rows()
    |> generate_rows()
    |> generate_dividers()
    |> generate_header_and_footer()
    |> build()
  end

  defp calculate_board_rows(board) do
    total = zero_indexed_board(board)
    side_length = Board.side_length(board)

    %{
      board: board,
      total: total,
      side_length: side_length,
      rows: Enum.chunk_every(0..total, side_length),
      contents: []
    }
  end

  defp generate_rows(%{board: board, rows: rows, total: total} = board_data) do
    %{board_data | :contents => Enum.map(rows, &row(board, &1, total))}
  end

  defp row(board, range, total) do
    Enum.reduce(range, "", fn pos, acc -> acc <> square(board, pos, total) end) <> "|"
  end

  defp square(board, position, total) do
    square =
      Board.get(board, position)
      |> case do
        "" -> humanise(position) |> pad("0", total) |> fade()
        mark -> mark |> pad(" ", total)
      end

    "| #{square} "
  end

  defp pad(string, padding, total) when total > 9, do: String.pad_leading(string, 2, padding)
  defp pad(string, _, _), do: string

  defp generate_dividers(%{contents: contents, side_length: side_length} = board_data) do
    %{
      board_data
      | :contents =>
          Enum.reduce(contents, [], fn row, acc ->
            acc ++ [row] ++ [divider(side_length)]
          end)
    }
  end

  defp divider(side_length) do
    square_width = if side_length > 3, do: 5, else: 4

    final_border_width = 1
    edges_total = 2
    width = square_width * side_length + final_border_width - edges_total
    ["+" <> Enum.reduce(1..width, "", fn _, acc -> acc <> "-" end) <> "+"]
  end

  defp generate_header_and_footer(%{contents: contents, side_length: side_length} = board_data) do
    %{board_data | :contents => [divider(side_length)] ++ contents ++ [[""]]}
  end

  defp build(%{contents: contents}), do: Enum.join(contents, "\n")

  defp zero_indexed_board(board), do: Board.size(board) - 1

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
