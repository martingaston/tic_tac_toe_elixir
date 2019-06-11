defmodule TicTacToe.Players do
  def create(:human_vs_human), do: [PlayerHuman, PlayerHuman]
  def create(:human_vs_minimax), do: [PlayerHuman, PlayerMinimax]
end
