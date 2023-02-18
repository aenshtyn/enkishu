defmodule Farm.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :activity, :string
      add :day, :naive_datetime
      add :cost, :integer
      add :cow_id, references(:cows, on_delete: :delete_all)

      timestamps()
    end

    create index(:events, [:cow_id])
    create unique_index(:events, [:day, :cow_id])
  end
end
