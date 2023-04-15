defmodule Farm.Finance.Sales do
  use Ecto.Schema
  import Ecto.Changeset
  alias Farm.Inventory.Product

  schema "sales" do
    field :customer_name, :string
    field :day, :naive_datetime
    field :price, :float
    field :quantity, :float
    field :unit, :string
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(sales, attrs) do
    sales
    |> cast(attrs, [:day, :customer_name, :unit, :quantity, :price])
    |> validate_required([:day, :customer_name, :unit, :quantity, :price])
  end
end
