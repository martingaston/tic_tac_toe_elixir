defmodule Game do
  @enforce_keys [:board, :board_manager, :ui, :io, :out, :device, :players]
  defstruct [:board_manager, :board, :ui, :io, :in, :out, :device, :players]
end
