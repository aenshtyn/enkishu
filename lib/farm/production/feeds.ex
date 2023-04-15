defmodule Farm.Production.Feeds do
  use Ecto.Schema
  import Ecto.Changeset

  alias Farm.Production.Feeding

  schema "feeds" do
    field :name, :string
    field :quantity, :integer
    field :weight, :integer

    timestamps()
  end

  @doc false
  def changeset(feeds, attrs) do
    feeds
    |> cast(attrs, [:name, :quantity, :weight])
    |> validate_required([:name, :quantity, :weight])
  end
end
