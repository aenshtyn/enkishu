defmodule Farm.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Farm.Animals.Cow

  schema "events" do
    field :activity, :string
    field :cost, :integer
    field :day, :naive_datetime
    field :name, :string
    belongs_to :cow, Cow
    # field :cow_id, :id

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :activity, :day, :cost, :cow_id])
    |> validate_required([:name, :activity, :day, :cost])
  end
end
