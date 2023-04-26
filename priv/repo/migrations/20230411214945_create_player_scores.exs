defmodule ElixirWPM.Repo.Migrations.CreatePlayerScores do
  use Ecto.Migration

  def change do
    create table(:player_scores) do
      add :total_score, :integer, null: false
      add :player_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:player_scores, [:player_id])
  end
end
