defmodule Farm.Repo.Migrations.CreateArable do
  use Ecto.Migration

  def change do
    create table(:arable) do
      add :number, :integer
      add :size, :float
      add :description, :text
      add :patron_id, references(:patrons, on_delete: :nothing)

      timestamps()
    end

    create index(:arable, [:patron_id])
    create unique_index(:paddocks, [:number])
  end
end
