defmodule Farm.HR.Duty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "duties" do
    field :day, :date
    field :description, :string
    field :name, :string
    belongs_to :worker, Farm.Hr.Worker

    timestamps()
  end

  @doc false
  def changeset(duty, attrs) do
    duty
    |> cast(attrs, [:day, :name, :description])
    |> validate_required([:day, :name, :description])
  end
end
