defmodule ElixirWPM.Leaderboards.PlayerScore do
  use Ecto.Schema
  import Ecto.Changeset

  schema "player_scores" do
    field :total_score, :integer
    field :player_id, :id
    field :player_name, :string
    timestamps()
  end

  @doc false
  def changeset(player_score, attrs) do
    player_score
    |> cast(attrs, [:total_score, :player_id, :player_name])
    |> validate_required([:total_score, :player_id, :player_name])
    |> foreign_key_constraint(:player_id)
  end
end
