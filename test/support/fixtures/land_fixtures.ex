defmodule Farm.LandFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Land` context.
  """

  @doc """
  Generate a layout.
  """
  def layout_fixture(attrs \\ %{}) do
    {:ok, layout} =
      attrs
      |> Enum.into(%{
        description: "some description",
        number: 42,
        size: 120.5
      })
      |> Farm.Land.create_layout()

    layout
  end

  @doc """
  Generate a paddock.
  """
  def paddock_fixture(attrs \\ %{}) do
    {:ok, paddock} =
      attrs
      |> Enum.into(%{
        description: "some description",
        number: 42,
        size: 120.5
      })
      |> Farm.Land.create_paddock()

    paddock
  end

  @doc """
  Generate a arable_land.
  """
  def arable_land_fixture(attrs \\ %{}) do
    {:ok, arable_land} =
      attrs
      |> Enum.into(%{
        description: "some description",
        number: 42,
        size: 120.5
      })
      |> Farm.Land.create_arable_land()

    arable_land
  end

  @doc """
  Generate a arable.
  """
  def arable_fixture(attrs \\ %{}) do
    {:ok, arable} =
      attrs
      |> Enum.into(%{
        description: "some description",
        number: 42,
        size: 120.5
      })
      |> Farm.Land.create_arable()

    arable
  end
end
