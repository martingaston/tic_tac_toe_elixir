defmodule Board do
  @empty_square ""
  @moduledoc """
  Contains functions to determine board management - creation, updating and determining if a player has filled a row, column or diagonal
  """

  @doc """
  Return an empty board
  """
  def new(size \\ :three_by_three)

  def new(:four_by_four) do
    create_board(15)
  end

  def new(:three_by_three) do
    create_board(8)
  end

  defp create_board(total), do: Enum.reduce(0..total, %{}, &Map.put(&2, &1, @empty_square))

  @doc """
  Update an existing board in the specified position with a specified mark. Does not overwrite existing marks.
  """
  def update(board, pos, mark) do
    case get(board, pos) do
      @empty_square -> Map.put(board, pos, mark)
      _ -> board
    end
  end

  def get(board, pos) do
    case Map.fetch(board, pos) do
      {:ok, square} -> square
      _ -> :error
    end
  end

  @doc """
  Recieves a board and a position and returns a bool indicating if the requested position is available
  """
  def available?(board, position) do
    case get(board, position) do
      :error -> false
      square -> square == @empty_square
    end
  end

  def available_positions(board) do
    board
    |> Enum.filter(fn {_, occupant} -> occupant == @empty_square end)
    |> Enum.map(fn {position, _} -> position end)
  end

  def status(board) do
    cond do
      moves?(board) == :no_moves -> :drawn
      hasWon?(board) -> :won
      true -> :active
    end
  end

  def size(board), do: map_size(board)

  def side_length(board), do: size(board) |> :math.sqrt() |> round()

  def moves?(board) do
    board
    |> Enum.filter(fn {_, occupant} -> occupant == @empty_square end)
    |> case do
      [] -> :no_moves
      moves -> Enum.count(moves)
    end
  end

  @doc """
  Recieves a board state and determines if any winning combinations exist
  """
  def hasWon?(board) do
    rows = Enum.chunk_every(0..(size(board) - 1), side_length(board))

    columns = Enum.map(0..2, fn x -> Enum.take_every(x..8, 3) end)

    left_diagonal = Enum.reduce(rows, [], fn x, acc -> acc ++ [Enum.at(x, length(acc))] end)

    right_diagonal = Enum.reduce(rows, [], fn x, acc -> acc ++ [Enum.at(x, 2 - length(acc))] end)

    win = rows ++ columns ++ [left_diagonal, right_diagonal]

    Enum.any?(win, fn x ->
      values =
        Map.take(board, x)
        |> Map.values()

      Enum.count(values) == 3 && hd(values) != @empty_square &&
        Enum.all?(values, &(&1 == hd(values)))
    end)
  end
end
