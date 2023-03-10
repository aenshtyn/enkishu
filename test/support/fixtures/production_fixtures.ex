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
end
