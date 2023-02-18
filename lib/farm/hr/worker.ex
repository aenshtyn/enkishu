defmodule Farm.HR.Worker do
  use Ecto.Schema
  import Ecto.Changeset
  alias Farm.HR.Role

  schema "workers" do
    field :address, :string
    field :dob, :naive_datetime
    field :name, :string
    field :phone_number, :integer
    field :report_date, :naive_datetime
    belongs_to :role, Role
    # belongs_to :salary, Salary

    timestamps()
  end

  @doc false
  def changeset(worker, attrs) do
    worker
    |> cast(attrs, [:dob, :name, :phone_number, :report_date, :address, :role_id])
    |> validate_required([:dob, :name, :phone_number, :report_date, :address, :role_id])
  end
end
