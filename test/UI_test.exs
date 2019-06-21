defmodule UiTest do
  use ExUnit.Case

  @full_3x3_board_string "+-----------+\n| X | O | O |\n+-----------+\n| O | X | X |\n+-----------+\n| X | X | O |\n+-----------+\n"
  @empty_4x4_board_string "+-------------------+\n| \e[38;5;242m01\e[0m | \e[38;5;242m02\e[0m | \e[38;5;242m03\e[0m | \e[38;5;242m04\e[0m |\n+-------------------+\n| \e[38;5;242m05\e[0m | \e[38;5;242m06\e[0m | \e[38;5;242m07\e[0m | \e[38;5;242m08\e[0m |\n+-------------------+\n| \e[38;5;242m09\e[0m | \e[38;5;242m10\e[0m | \e[38;5;242m11\e[0m | \e[38;5;242m12\e[0m |\n+-------------------+\n| \e[38;5;242m13\e[0m | \e[38;5;242m14\e[0m | \e[38;5;242m15\e[0m | \e[38;5;242m16\e[0m |\n+-------------------+\n"

  test "Ui.draw_board/1 should output current game state" do
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

    assert Ui.draw_board(board) == @full_3x3_board_string
  end

  test "Ui.draw_board/1 can output a 4x4 board" do
    board = Board.new(:four_by_four)

    assert Ui.draw_board(board) == @empty_4x4_board_string
  end
end
