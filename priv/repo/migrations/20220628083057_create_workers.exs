defmodule Farm.Repo.Migrations.CreateWorkers do
  use Ecto.Migration

  def change do
    create table(:workers) do
      add :dob, :naive_datetime
      add :name, :string
      add :phone_number, :integer
      add :report_date, :naive_datetime
      add :address, :string
      add :role_id, references(:roles, on_delete: :nothing)
      add :salary, references(:salarys, on_delete: :nothing)

      timestamps()
    end
    create unique_index(:workers, [:name])
    create index(:workers, [:role_id])
    # create index(:workers, [:salary])
  end
end
