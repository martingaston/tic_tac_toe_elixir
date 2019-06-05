defmodule TicTacToe.Io do
  def get_position(io \\ :stdio, msg \\ "") do
    input = input(io, msg)
    error = "That input is invalid. Please enter a valid input."

    case Integer.parse(input) do
      {int, _} -> computerise(int)
      _ -> get_position(io, error)
    end
  end

  defp computerise(position) do
    position - 1
  end

  defp input(io, msg) do
    IO.gets(io, msg)
  end
end
