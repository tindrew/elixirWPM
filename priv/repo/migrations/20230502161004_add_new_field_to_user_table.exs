defmodule ElixirWPM.Repo.Migrations.AddNewFieldToUserTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :player_name, :string
    end
  end
end
