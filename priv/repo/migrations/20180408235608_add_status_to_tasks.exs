defmodule ProjectusApi.Repo.Migrations.AddStatusToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :status, :integer, null: false, default: 0
    end
  end
end
