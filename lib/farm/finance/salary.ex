defmodule Farm.Finance.Salary do
  use Ecto.Schema
  import Ecto.Changeset

  schema "salarys" do
    field :amount, :float
    field :grade, :integer

    timestamps()
  end

  @doc false
  def changeset(salary, attrs) do
    salary
    |> cast(attrs, [:grade, :amount])
    |> validate_required([:grade, :amount])
  end
end
