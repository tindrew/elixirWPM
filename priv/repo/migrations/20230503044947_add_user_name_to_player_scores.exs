defmodule ElixirWPM.Repo.Migrations.AddUserNameToPlayerScores do
  use Ecto.Migration

  def change do
    alter table(:player_scores) do
      add :player_name, :string, null: false
    end
  end
end
