defmodule Farm.Animals.Cow do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Farm.HR.Patron
  alias Farm.Inventory.Product

  schema "cows" do
    field(:breed, :string)
    field(:dob, :date)
    field(:age, :integer)
    field(:name, :string)
    belongs_to :patron, Patron
    belongs_to :product, Product
    has_many(:events, Farm.Events.Event)
    has_many(:milks, Farm.Products.Milk)

    timestamps()
  end

  @doc false
  def changeset(cow, attrs) do
    cow
    |> cast(attrs, [:name, :dob, :breed, :patron_id, :age, :product_id ])
    |> validate_required([:name, :dob, :breed, :patron_id])
    |> age_in_months()
  end

  defp age_in_months(%Ecto.Changeset{valid?: true, changes: %{dob: dob}} = changeset) do
    change(
      changeset,
      age: calculate_age(dob)
    )
  end

  defp age_in_months(changeset), do: changeset

  def calculate_age(dob) do
    (Date.utc_today().year - dob.year) * 12 + (Date.utc_today().month - dob.month)
  end

  def cow_query(queryable \\ __MODULE__) do
    from(c in queryable, select: %{name: c.name, id: c.id})
  end
end
