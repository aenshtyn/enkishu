defmodule Farm.Repo.Migrations.CreateDuties do
  use Ecto.Migration

  def change do
    create table(:duties) do
      add :day, :naive_datetime
      add :name, :string
      add :description, :text
      add :worker_id, references(:workers, on_delete: :nothing)

      timestamps()
    end

    create index(:duties, [:worker_id])
  end
end
