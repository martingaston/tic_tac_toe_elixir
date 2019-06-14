defmodule Game do
  @enforce_keys [:board, :board_manager, :ui, :out, :in, :players]
  defstruct [:board_manager, :board, :ui, :in, :out, :players]
end
