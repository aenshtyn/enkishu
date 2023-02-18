defmodule Farm.GalleryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Gallery` context.
  """

  @doc """
  Generate a photo.
  """
  def photo_fixture(attrs \\ %{}) do
    {:ok, photo} =
      attrs
      |> Enum.into(%{
        photo: "some photo",
        uuid: "some uuid"
      })
      |> Farm.Gallery.create_photo()

    photo
  end
end
