defmodule Display do
  def print(_state, io) do
    str =
      "+-----------+\n" <>
        "| X | O | O |\n" <>
        "+-----------+\n" <>
        "| O | X | X |\n" <>
        "+-----------+\n" <>
        "| X | X | O |\n" <>
        "+-----------+\n"

    out(str, io)
  end

  defp out(contents, io \\ :stdio) do
    IO.write(io, contents)
  end
end
