defmodule Farm.Repo.Migrations.CreateFeeds do
  use Ecto.Migration

  def change do
    create table(:feeds) do
      add :name, :string
      add :quantity, :integer
      add :weight, :integer

      timestamps()
    end
  end
end
