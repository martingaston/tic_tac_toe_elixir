defmodule DisplayState do
  defstruct [:ui, :in, :out]

  def new(io, ui, device) do
    %DisplayState{
      ui: ui,
      in: fn ->
        io.input(device) |> Log.out()
      end,
      out: fn message -> io.output(device, message) |> Log.out() end
    }
  end
end
