defmodule Farm.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string
      add :phone_number, :integer
      add :location, :string

      timestamps()
    end
  end
end
