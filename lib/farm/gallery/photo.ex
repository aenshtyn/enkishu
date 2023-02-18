defmodule Farm.Gallery.Photo do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  schema "photos" do
    field :photo, Farm.Photo.Type
    field :uuid, :string

    timestamps()
  end

  @doc false
  def changeset(photo, attrs) do
    photo
    |> cast(attrs, [:uuid])
    |> cast_attachments(attrs, [:photo])
    |> validate_required([:photo, :uuid])
  end
end
