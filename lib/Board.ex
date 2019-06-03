defmodule Board do
  def new do
    Enum.reduce(0..8, %{}, fn pos, board -> Map.put(board, pos, "") end)
  end

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

      length(values) == 3 && hd(values) != "" && Enum.all?(values, fn x -> x == hd(values) end)
    end)
  end
end
