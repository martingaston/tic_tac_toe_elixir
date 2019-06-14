defmodule UITest do
  use ExUnit.Case

  test "UI.draw_board/1 should output current game state" do
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

    assert UI.draw_board(board) ==
             "+-----------+\n| X | O | O |\n+-----------+\n| O | X | X |\n+-----------+\n| X | X | O |\n+-----------+\n"
  end
end
