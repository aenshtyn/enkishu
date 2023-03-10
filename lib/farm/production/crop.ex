defmodule Farm.Production.Crop do
  use Ecto.Schema
  import Ecto.Changeset
  alias Farm.Inventory.Product
  alias Farm.Land.Paddock

  schema "crops" do
    field :fertilizer, :boolean, default: false
    field :maturity, :integer
    field :name, :string
    field :plating_day, :date
    field :production_per_acre, :integer
    field :rainfall_requirements, :integer
    field :scientific_name, :string
    field :variety, :string
    field :weeding, :boolean, default: false
    belongs_to :product, Product
    belongs_to :paddock, Paddock


    timestamps()
  end

  @doc false
  def changeset(crop, attrs) do
    crop
    |> cast(attrs, [:name, :variety, :scientific_name, :plating_day, :production_per_acre, :rainfall_requirements, :maturity, :weeding, :fertilizer, :paddock_id])
    |> validate_required([:name, :variety, :scientific_name, :plating_day, :production_per_acre, :rainfall_requirements, :maturity, :weeding, :fertilizer, :paddock_id])
  end
end
