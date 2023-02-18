defmodule Farm.Land.Arable do
  use Ecto.Schema
  import Ecto.Changeset
  alias Farm.HR.Patron

  schema "arable" do
    field :description, :string
    field :number, :integer
    field :size, :float
    belongs_to :patron, Patron
    timestamps()
  end

  @doc false
  def changeset(arable, attrs) do
    arable
    |> cast(attrs, [:number, :size, :description])
    |> validate_required([:number, :size, :description])
  end
end
