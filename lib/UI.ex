defmodule UI do
  def show_board(state, io \\ :stdio) do
    print_header(io)
    print_row(state, 0..2, io)
    print_header(io)
    print_row(state, 3..5, io)
    print_header(io)
    print_row(state, 6..8, io)
    print_header(io)
  end

  defp print_header(io) do
    out("+-----------+\n", io)
  end

  defp print_row(state, range, io) do
    Enum.each(range, fn pos -> print_square(state, pos, io) end)
    out("|\n", io)
  end

  defp print_square(state, position, io) do
    out("| #{Map.get(state, position) || humanise(position)} ", io)
  end

  defp out(contents, io) do
    IO.write(io, contents)
  end

  defp humanise(position) do
    Integer.to_string(position + 1)
  end
end
