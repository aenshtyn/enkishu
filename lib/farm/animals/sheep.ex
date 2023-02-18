defmodule Farm.Animals.Sheep do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sheeps" do
    field :age, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(sheep, attrs) do
    sheep
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
