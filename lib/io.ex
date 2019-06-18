defmodule TicTacToe.Io do
  def get_position(io \\ :stdio) do
    input(io)
    |> Integer.parse()
    |> case do
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

  def output(io, contents) when is_list(contents) do
    output(io, Enum.join(contents, "\n") <> "\n")
  end

  def output(io, contents) do
    IO.write(io, contents)
    contents
  end
end
