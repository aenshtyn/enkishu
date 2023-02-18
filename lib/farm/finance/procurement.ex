defmodule Farm.Finance.Procurement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "procurements" do
    field :day, :naive_datetime
    field :quantity, :float
    field :unit, :string
    field :vendor_name, :string

    timestamps()
  end

  @doc false
  def changeset(procurements, attrs) do
    procurements
    |> cast(attrs, [:day, :vendor_name, :unit, :quantity])
    |> validate_required([:day, :vendor_name, :unit, :quantity])
  end
end
