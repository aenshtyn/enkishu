defmodule Farm.Repo.Migrations.CreateSheeps do
  use Ecto.Migration

  def change do
    create table(:sheeps) do
      add :name, :string
      add :age, :string

      timestamps()
    end
  end
end
