defmodule Board do
  @empty_square ""
  @moduledoc """
  Contains functions to determine board management - creation, updating and determining if a player has filled a row, column or diagonal
  """

  @doc """
  Return an empty board
  """
  def new do
    Enum.reduce(0..8, %{}, &Map.put(&2, &1, @empty_square))
  end

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
    win = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    Enum.any?(win, fn x ->
      values =
        Map.take(board, x)
        |> Map.values()

      Enum.count(values) == 3 && hd(values) != @empty_square &&
        Enum.all?(values, &(&1 == hd(values)))
    end)
  end
end
