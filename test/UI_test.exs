defmodule UITest do
  use ExUnit.Case

  # TODO replace with Board.new() API when implemented
  @board %{
    0 => "X",
    1 => "O",
    2 => "O",
    3 => "O",
    4 => "X",
    5 => "X",
    6 => "X",
    7 => "X",
    8 => "O"
  }

  test "UI.show_board/2 should output current game state" do
    {:ok, io} = StringIO.open("")
    UI.print_board(@board, io)

    assert StringIO.flush(io) ==
             "+-----------+\n| X | O | O |\n+-----------+\n| O | X | X |\n+-----------+\n| X | X | O |\n+-----------+\n"
  end

  test "UI.show_board_string/1 should output current game state" do
    board =
      Board.new()
      |> Board.update(0, "X")
      |> Board.update(1, "O")
      |> Board.update(2, "O")
      |> Board.update(3, "O")
      |> Board.update(4, "X")
      |> Board.update(5, "X")
      |> Board.update(6, "X")
      |> Board.update(7, "X")
      |> Board.update(8, "O")

    assert UI.print_board_string(board) ==
             "+-----------+\n| X | O | O |\n+-----------+\n| O | X | X |\n+-----------+\n| X | X | O |\n+-----------+\n"
  end
end
