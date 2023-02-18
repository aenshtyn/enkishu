defmodule Farm.Repo.Migrations.CreatePatrons do
  use Ecto.Migration

  def change do
    create table(:patrons) do
      add :name, :string
      add :phone_number, :integer
      add :address, :string
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create index(:patrons, [:role_id])
  end
end
