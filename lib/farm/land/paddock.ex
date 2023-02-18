defmodule Farm.Land.Paddock do
  use Ecto.Schema
  import Ecto.Changeset

  alias Farm.HR.Patron

  schema "paddocks" do
    field :description, :string
    field :number, :integer
    field :size, :float
    belongs_to :patron, Patron

    timestamps()
  end

  @doc false
  def changeset(paddock, attrs) do
    paddock
    |> cast(attrs, [:number, :size, :description])
    |> validate_required([:number, :size, :description])
  end
end
