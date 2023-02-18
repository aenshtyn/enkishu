defmodule Farm.Repo.Migrations.CreateProcurements do
  use Ecto.Migration

  def change do
    create table(:procurements) do
      add :day, :naive_datetime
      add :vendor_name, :string
      add :unit, :string
      add :quantity, :float
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:procurements, [:day])
  end
end
