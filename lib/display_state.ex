defmodule DisplayState do
  defstruct [:io, :device, :ui, :in, :out]

  def new(io, ui, device) do
    %DisplayState{
      ui: ui,
      in: fn -> io.get_position(device) end,
      out: fn message -> io.output(device, message) end
    }
  end
end

