defmodule Farm.Repo.Migrations.CreatePaddocks do
  use Ecto.Migration

  def change do
    create table(:paddocks) do
      add :number, :integer
      add :size, :float
      add :description, :text
      add :patron_id, references(:patrons, on_delete: :nothing)

      timestamps()
    end

    create index(:paddocks, [:patron_id])
  end
end
