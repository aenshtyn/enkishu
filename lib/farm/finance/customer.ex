defmodule Farm.Finance.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :location, :string
    field :name, :string
    field :phone_number, :integer

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :phone_number, :location])
    |> validate_required([:name, :phone_number, :location])
  end
end
