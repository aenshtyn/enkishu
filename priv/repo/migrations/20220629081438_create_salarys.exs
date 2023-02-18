defmodule Farm.Repo.Migrations.CreateSalarys do
  use Ecto.Migration

  def change do
    create table(:salarys) do
      add :grade, :integer
      add :amount, :float

      timestamps()
    end
  end
end
