defmodule ElixirWPM.Repo.Migrations.CreatePlayerScores do
  use Ecto.Migration

  def change do
    create table(:player_scores) do
      add :total_score, :integer
      add :player_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:player_scores, [:player_id])
  end
end
