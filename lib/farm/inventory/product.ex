defmodule Farm.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :quantity, :float
    field :unit, :string
    has_many :cows, Farm.Animals.Cow
    has_many(:milks, Farm.Products.Milk)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :unit, :quantity])
    |> validate_required([:name, :unit, :quantity])
  end
end
