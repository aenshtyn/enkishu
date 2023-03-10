defmodule Farm.Repo.Migrations.CreateMedications do
  use Ecto.Migration

  def change do
    create table(:medications) do
      add :brand, :string
      add :type, :string
      add :patient, :string

      timestamps()
    end

    create unique_index(:tags, [:name])
  end
end
