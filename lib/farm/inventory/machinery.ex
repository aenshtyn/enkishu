defmodule Farm.Inventory.Machinery do
  use Ecto.Schema
  import Ecto.Changeset

  schema "machinerys" do
    field :area_of_use, :string
    field :brand, :string
    field :hp, :float
    field :name, :string
    field :price, :float

    timestamps()
  end

  @doc false
  def changeset(machinery, attrs) do
    machinery
    |> cast(attrs, [:name, :brand, :hp, :price, :area_of_use])
    |> validate_required([:name, :brand, :hp, :price, :area_of_use])
  end
end
