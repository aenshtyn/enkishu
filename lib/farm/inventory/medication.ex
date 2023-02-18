defmodule Farm.Inventory.Medication do
  use Ecto.Schema
  import Ecto.Changeset

  schema "medications" do
    field :brand, :string
    field :patient, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(medication, attrs) do
    medication
    |> cast(attrs, [:brand, :type, :patient])
    |> validate_required([:brand, :type, :patient])
  end
end
