defmodule Farm.Repo.Migrations.CreateMachinerys do
  use Ecto.Migration

  def change do
    create table(:machinerys) do
      add :name, :string
      add :brand, :string
      add :hp, :float
      add :price, :float
      add :area_of_use, :string

      timestamps()
    end
  end
end
