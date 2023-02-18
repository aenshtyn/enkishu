defmodule Farm.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :unit, :string
      add :quantity, :float

      timestamps()
    end
  end
end
