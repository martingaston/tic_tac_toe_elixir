defmodule TicTacToe.Players do
  def create(:human_vs_human), do: [PlayerHuman, PlayerHuman]
  def create(:human_vs_minimax), do: [PlayerHuman, PlayerMinimax]
  def create(:minimax_vs_minimax), do: [PlayerMinimax, PlayerMinimax]

  def next_turn(players) do
    Enum.reverse(players)
  end

  def current_mark(players) do
    {mark, _} = List.first(players)
    mark
  end

  def opponent_mark(players) do
    {mark, _} = List.last(players)
    mark
  end

  def current_player(players) do
    {_, player} = List.first(players)
    player
  end
end

defprotocol Player do
  def choose_move(player, board)
end
