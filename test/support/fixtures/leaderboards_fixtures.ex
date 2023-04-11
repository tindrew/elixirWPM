defmodule ElixirWPM.LeaderboardsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirWPM.Leaderboards` context.
  """

  @doc """
  Generate a player_score.
  """
  def player_score_fixture(attrs \\ %{}) do
    {:ok, player_score} =
      attrs
      |> Enum.into(%{
        total_score: 42
      })
      |> ElixirWPM.Leaderboards.create_player_score()

    player_score
  end
end
