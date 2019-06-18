defmodule TicTacToe.Io do
  def input(io) do
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
