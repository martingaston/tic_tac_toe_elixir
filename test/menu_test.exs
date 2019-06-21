defmodule MenuTest do
  use ExUnit.Case

  describe "Menu.get_mode/2" do
    test "returns atom for human vs human if input is 1" do
      {:ok, io} = StringIO.open("1")
      display = DisplayState.new(TicTacToe.Io, Ui, io)

      assert Menu.get_mode(display) == :human_vs_human
    end

    test "returns atom for human vs minimax if input is 2" do
      {:ok, io} = StringIO.open("2")
      display = DisplayState.new(TicTacToe.Io, Ui, io)

      assert Menu.get_mode(display) == :human_vs_minimax
    end

    test "returns atom for minimax vs minimax if input is 3" do
      {:ok, io} = StringIO.open("3")
      display = DisplayState.new(TicTacToe.Io, Ui, io)

      assert Menu.get_mode(display) == :minimax_vs_minimax
    end

    test "returns makes user re-enter input until correct mode number is provided" do
      {:ok, io} = StringIO.open("-15\ncat\nhorse\n205\n1")
      display = DisplayState.new(TicTacToe.Io, Ui, io)

      assert Menu.get_mode(display) == :human_vs_human
    end
  end

  describe "Menu.get_board/2" do
    test "returns atom for three by three if input is 1" do
      {:ok, io} = StringIO.open("1")
      display = DisplayState.new(TicTacToe.Io, Ui, io)

      assert Menu.get_board_size(display) == :three_by_three
    end

    test "returns atom for four by four if input is 2" do
      {:ok, io} = StringIO.open("2")
      display = DisplayState.new(TicTacToe.Io, Ui, io)

      assert Menu.get_board_size(display) == :four_by_four
    end

    test "returns makes user re-enter input until correct mode number is provided" do
      {:ok, io} = StringIO.open("-15\ncat\nhorse\n205\n3\n1")
      display = DisplayState.new(TicTacToe.Io, Ui, io)

      assert Menu.get_board_size(display) == :three_by_three
    end
  end
end
