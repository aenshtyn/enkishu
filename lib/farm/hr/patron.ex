defmodule Farm.HR.Patron do
  use Ecto.Schema
  import Ecto.Changeset
  alias Farm.HR.Role

  schema "patrons" do
    field :address, :string
    field :name, :string
    field :phone_number, :integer
    belongs_to :role, Role
    has_many(:cows, Farm.Animals.Cow)

    timestamps()
  end

  @doc false
  def changeset(patron, attrs) do
    patron
    |> cast(attrs, [:name, :phone_number, :address, :role_id])
    |> validate_required([:name, :phone_number, :address, :role_id])
  end
end
