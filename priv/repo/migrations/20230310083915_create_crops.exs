defmodule Farm.Repo.Migrations.CreateCrops do
  use Ecto.Migration

  def change do
    create table(:crops) do
      add :name, :string
      add :variety, :string
      add :scientific_name, :string
      add :plating_day, :date
      add :production_per_acre, :integer
      add :rainfall_requirements, :integer
      add :maturity, :integer
      add :weeding, :boolean, default: false, null: false
      add :fertilizer, :boolean, default: false, null: false
      add :product_id, references(:products, on_delete: :nothing)
      add :paddock_id, references(:paddocks, on_delete: :nothing)

      timestamps()
    end
  end
end
