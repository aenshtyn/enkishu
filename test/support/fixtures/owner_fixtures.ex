defmodule Farm.OwnerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Owner` context.
  """

  @doc """
  Generate a patron.
  """
  def patron_fixture(attrs \\ %{}) do
    {:ok, patron} =
      attrs
      |> Enum.into(%{
        name: "some name",
        phone_number: 42
      })
      |> Farm.Owner.create_patron()

    patron
  end
end
