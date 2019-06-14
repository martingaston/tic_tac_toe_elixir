defmodule Game do
  @enforce_keys [:board, :board_manager, :ui, :io, :players]
  defstruct [:board_manager, :board, :ui, :io, :players]
end
