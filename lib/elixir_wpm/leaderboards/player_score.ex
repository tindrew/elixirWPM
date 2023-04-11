defmodule ElixirWPM.Leaderboards.PlayerScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_scores" do
    field :total_score, :integer
    field :player_id, :id

    timestamps()
  end

  @doc false
  def changeset(player_score, attrs) do
    player_score
    |> cast(attrs, [:total_score])
    |> validate_required([:total_score])
  end
end
