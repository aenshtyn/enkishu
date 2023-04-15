defmodule Farm.Production.Feeding do
  use Ecto.Schema
  import Ecto.Changeset

  # alias Farm.Production.Feeds
  schema "feedings" do
    field :day, :date
    field :volume, :integer
    field :paddock_id, :id
    has_many(:feeds, Farm.Production.Feeds)

    timestamps()
  end

  @doc false
  def changeset(feeding, attrs) do
    feeding
    |> cast(attrs, [:day, :volume, :feeds])
    |> validate_required([:day, :volume])
  end
end
