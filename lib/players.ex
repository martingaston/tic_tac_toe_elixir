defmodule TicTacToe.Players do
  def create(:minimax, player_mark, opponent_mark) do
    PlayerMinimax.new(player_mark, opponent_mark)
  end

  def create(:human_vs_human, %DisplayState{} = display) do
    [PlayerHuman.new(display), PlayerHuman.new(display)]
  end

  def create(:human_vs_minimax, %DisplayState{} = display) do
    [PlayerHuman.new(display), PlayerMinimax.new("O", "X")]
  end

  def create(:minimax_vs_minimax, _) do
    [PlayerMinimax.new("X", "O"), PlayerMinimax.new("O", "X")]
  end

  def create(:human_vs_minimax), do: [PlayerHuman, PlayerMinimax]

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
