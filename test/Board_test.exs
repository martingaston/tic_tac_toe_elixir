defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "new/0 returns a board of length 9" do
    assert Enum.count(Board.new()) == 9
  end

  test "new/0 returns an empty board" do
    assert Enum.all?(Board.new(), fn {_k, occupant} -> occupant == "" end)
  end

  test "update/3 adds a symbol to the board" do
    board = %{
      0 => ""
    }

    pos = 0
    player = "X"
    result = Board.update(board, pos, player)
    assert Map.fetch(result, 0) == {:ok, "X"}
  end

  test "update/3 does not overwrite occupied squares" do
    board = %{
      0 => "O"
    }

    pos = 0
    player = "X"
    result = Board.update(board, pos, player)
    assert Map.fetch(result, 0) == {:ok, "O"}
  end

  test "update/3 does not change the board if the requested update position is out of bounds" do
    board = %{
      0 => ""
    }

    pos = 1
    player = "X"
    result = Board.update(board, pos, player)
    assert result == %{0 => ""}
  end

  test "hasWon returns false if board is empty" do
    board = %{
      0 => "",
      1 => "",
      2 => ""
    }

    assert Board.hasWon?(board) == false
  end

  test "hasWon returns true if player has won with top horizontal line" do
    board = %{
      0 => "X",
      1 => "X",
      2 => "X"
    }

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns false if player has not won with top horizontal line" do
    board = %{
      0 => "X",
      1 => "O",
      2 => "X"
    }

    assert Board.hasWon?(board) == false
  end

  test "hasWon returns true if player has won with middle horizontal line" do
    board = %{
      3 => "X",
      4 => "X",
      5 => "X"
    }

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with bottom horizontal line" do
    board = %{
      6 => "X",
      7 => "X",
      8 => "X"
    }

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with left vertical line" do
    board = %{
      0 => "X",
      3 => "X",
      6 => "X"
    }

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with middle vertical line" do
    board = %{
      1 => "X",
      4 => "X",
      7 => "X"
    }

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with right vertical line" do
    board = %{
      2 => "X",
      5 => "X",
      8 => "X"
    }

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with left diagonal line" do
    board = %{
      0 => "X",
      4 => "X",
      8 => "X"
    }

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with right diagonal line" do
    board = %{
      2 => "X",
      4 => "X",
      6 => "X"
    }

    assert Board.hasWon?(board) == true
  end
end
