defmodule Farm.Repo.Migrations.CreateFeedings do
  use Ecto.Migration

  def change do
    create table(:feedings) do
      add :day, :date
      add :volume, :integer
      add :paddock_id, references(:paddocks, on_delete: :nothing)
      add :feeds_id, references(:feeds, on_delete: :nothing)

      timestamps()
    end

    create index(:feedings, [:paddock_id])
    create index(:feedings, [:feeds_id])
  end
end
