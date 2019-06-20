defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "new/0 returns an empty board" do
    board = Board.new()
    assert Board.moves?(board) == 9
  end

  test "size/1 returns 9 for a default 3x3 board" do
    board = Board.new()
    assert Board.size(board) == 9
  end

  test "size/1 returns 16 for a 4x4 board" do
    board = Board.new(:four_by_four)
    assert Board.size(board) == 16
  end

  test "side_length/1 returns 3 for a default 3x3 board" do
    board = Board.new()
    assert Board.side_length(board) == 3
  end

  test "side_length/1 returns 4 for a 4x4 board" do
    board = Board.new(:four_by_four)
    assert Board.side_length(board) == 4
  end

  test "update/3 adds a symbol to the board" do
    board = Board.new()
    pos = 0
    player = "X"
    result = Board.update(board, pos, player)
    assert Board.get(result, 0) == "X"
  end

  test "update/3 does not overwrite occupied squares" do
    board = Board.new()
    pos = 0
    first_player = "X"
    first_move = Board.update(board, pos, first_player)
    second_player = "O"
    second_move = Board.update(first_move, pos, second_player)
    assert Board.get(second_move, 0) == "X"
  end

  test "update/3 does not change the board if the requested update position is out of bounds" do
    board = Board.new()
    pos = 10
    player = "X"
    result = Board.update(board, pos, player)
    assert result == Board.new()
  end

  test "hasWon returns false if board is empty" do
    board = Board.new()
    assert Board.hasWon?(board) == false
  end

  test "hasWon returns true if player has won with top horizontal line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(0, player)
      |> Board.update(1, player)
      |> Board.update(2, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns false if player has not won with top horizontal line" do
    first_player = "X"
    second_player = "O"

    board =
      Board.new()
      |> Board.update(0, first_player)
      |> Board.update(1, second_player)
      |> Board.update(2, first_player)

    assert Board.hasWon?(board) == false
  end

  test "hasWon returns true if player has won with middle horizontal line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(3, player)
      |> Board.update(4, player)
      |> Board.update(5, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with bottom horizontal line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(6, player)
      |> Board.update(7, player)
      |> Board.update(8, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with left vertical line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(0, player)
      |> Board.update(3, player)
      |> Board.update(6, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with middle vertical line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(1, player)
      |> Board.update(4, player)
      |> Board.update(7, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with right vertical line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(2, player)
      |> Board.update(5, player)
      |> Board.update(8, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with left diagonal line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(0, player)
      |> Board.update(4, player)
      |> Board.update(8, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with right diagonal line" do
    player = "X"

    board =
      Board.new()
      |> Board.update(2, player)
      |> Board.update(4, player)
      |> Board.update(6, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with top row on 4x4 board" do
    player = "X"

    board =
      Board.new(:four_by_four)
      |> Board.update(0, player)
      |> Board.update(1, player)
      |> Board.update(2, player)
      |> Board.update(3, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with right column on 4x4 board" do
    player = "X"

    board =
      Board.new(:four_by_four)
      |> Board.update(3, player)
      |> Board.update(7, player)
      |> Board.update(11, player)
      |> Board.update(15, player)

    assert Board.hasWon?(board) == true
  end

  test "hasWon returns true if player has won with diagonal on 4x4 board" do
    player = "X"

    board =
      Board.new(:four_by_four)
      |> Board.update(0, player)
      |> Board.update(5, player)
      |> Board.update(10, player)
      |> Board.update(15, player)

    assert Board.hasWon?(board) == true
  end
end
