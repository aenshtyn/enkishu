defmodule Farm.Repo.Migrations.CreateSales do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :day, :naive_datetime
      add :customer_name, :string
      add :unit, :string
      add :quantity, :float
      add :price, :float
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:sales, [:day])
  end
end
