defmodule Farm.ProductionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Production` context.
  """

  @doc """
  Generate a crop.
  """
  def crop_fixture(attrs \\ %{}) do
    {:ok, crop} =
      attrs
      |> Enum.into(%{
        fertilizer: true,
        maturity: 42,
        name: "some name",
        plating_day: ~D[2023-03-09],
        production_per_acre: 42,
        rainfall_requirements: 42,
        scientific_name: "some scientific_name",
        variety: "some variety",
        weeding: true
      })
      |> Farm.Production.create_crop()

    crop
  end

  @doc """
  Generate a feeding.
  """
  def feeding_fixture(attrs \\ %{}) do
    {:ok, feeding} =
      attrs
      |> Enum.into(%{
        day: ~D[2023-03-09],
        volume: 42
      })
      |> Farm.Production.create_feeding()

    feeding
  end

  @doc """
  Generate a feeds.
  """
  def feeds_fixture(attrs \\ %{}) do
    {:ok, feeds} =
      attrs
      |> Enum.into(%{
        name: "some name",
        quantity: 42,
        weight: 42
      })
      |> Farm.Production.create_feeds()

    feeds
  end
end
