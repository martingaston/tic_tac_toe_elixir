defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "new/0 returns a board of length 9" do
    assert Enum.count(Board.new()) == 9
  end

  test "new/0 returns an empty board" do
    assert Enum.all?(Board.new(), fn {_k, occupant} -> occupant == "" end)
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
