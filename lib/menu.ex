defmodule Menu do
  def get_mode(message \\ :choose_mode, %DisplayState{out: out, in: input, ui: ui} = display) do
    out.(ui.message(message))

    input.()
    |> coerce_int()
    |> validate_mode()
    |> case do
      {:error, error} -> get_mode(error, display)
      mode -> mode
    end
  end

  def get_board_size(
        message \\ :choose_board,
        %DisplayState{out: out, in: input, ui: ui} = display
      ) do
    out.(ui.message(message))

    input.()
    |> coerce_int()
    |> validate_board()
    |> case do
      {:error, error} -> get_board_size(error, display)
      board_size -> board_size
    end
  end

  defp validate_mode(mode_number) do
    case mode_number do
      1 -> :human_vs_human
      2 -> :human_vs_minimax
      3 -> :minimax_vs_minimax
      x when not is_integer(x) -> {:error, :nan}
      x when x < 1 or x > 3 -> {:error, :out_of_bounds}
      _ -> {:error, :unknown}
    end
  end

  defp validate_board(mode_number) do
    case mode_number do
      1 -> :three_by_three
      2 -> :four_by_four
      x when not is_integer(x) -> {:error, :nan}
      x when x < 1 or x > 2 -> {:error, :out_of_bounds}
      _ -> {:error, :unknown}
    end
  end

  defp coerce_int(string) do
    string
    |> Integer.parse()
    |> case do
      {int, _} -> int
      _ -> string
    end
  end
end
