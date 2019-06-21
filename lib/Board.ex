defmodule Board do
  @moduledoc """
  Contains functions to determine board management - creation, updating and determining if a player has filled a row, column or diagonal
  """
  @four_by_four_zero_indexed 15
  @three_by_three_zero_indexed 8
  @empty_square ""

  defstruct [:contents, :winning_moves]

  @doc """
  Return an empty board
  """
  def new(size \\ :three_by_three)

  def new(:four_by_four) do
    create_board(@four_by_four_zero_indexed)
  end

  def new(:three_by_three) do
    create_board(@three_by_three_zero_indexed)
  end

  defp create_board(total) do
    %Board{
      contents: Enum.reduce(0..total, %{}, &Map.put(&2, &1, @empty_square)),
      winning_moves: winning_moves(total)
    }
  end

  @doc """
  Update an existing board in the specified position with a specified mark. Does not overwrite existing marks.
  """
  def update(%Board{} = board, position, mark) do
    case get(board, position) do
      @empty_square -> %Board{board | contents: Map.put(board.contents, position, mark)}
      _ -> board
    end
  end

  def get(%Board{contents: contents}, position) do
    case Map.fetch(contents, position) do
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

  def available_positions(%Board{contents: contents}) do
    contents
    |> Enum.filter(fn {_, occupant} -> occupant == @empty_square end)
    |> Enum.map(fn {position, _} -> position end)
  end

  def status(%Board{} = board) do
    cond do
      moves?(board) == :no_moves -> :drawn
      hasWon?(board) -> :won
      true -> :active
    end
  end

  def size(%Board{contents: contents}), do: map_size(contents)

  def side_length(%Board{} = board), do: size(board) |> :math.sqrt() |> round()

  def moves?(board) do
    available_positions(board)
    |> case do
      [] -> :no_moves
      moves -> Enum.count(moves)
    end
  end

  @doc """
  Recieves a board state and determines if any winning combinations exist
  """
  def hasWon?(%Board{contents: contents, winning_moves: winning_moves} = board) do
    Enum.any?(winning_moves, fn x ->
      values =
        Map.take(contents, x)
        |> Map.values()

      Enum.count(values) == side_length(board) && List.first(values) != @empty_square &&
        Enum.all?(values, &(&1 == List.first(values)))
    end)
  end

  defp winning_moves(size) do
    side_length = :math.sqrt(size + 1) |> round()

    rows = Enum.chunk_every(0..size, side_length)

    columns = Enum.map(0..(side_length - 1), fn x -> Enum.take_every(x..size, side_length) end)

    left_diagonal = Enum.reduce(rows, [], fn x, acc -> acc ++ [Enum.at(x, length(acc))] end)

    right_diagonal =
      Enum.reduce(rows, [], fn x, acc -> acc ++ [Enum.at(x, side_length - 1 - length(acc))] end)

    # generate_rows() ++ generate_columns() ++ generate_diagonals()
    rows ++ columns ++ [left_diagonal, right_diagonal]
  end
end
