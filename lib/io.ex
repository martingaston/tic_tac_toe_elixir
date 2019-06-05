defmodule TicTacToe.Io do
  def get_position(io \\ :stdio) do
    input = input(io)

    case Integer.parse(input) do
      {int, _} -> computerise(int)
      _ -> get_position(io)
    end
  end

  defp computerise(position) do
    position - 1
  end

  defp input(io) do
    IO.gets(io, "")
  end

  def output(io, contents) do
    IO.write(io, contents)
  end
end
