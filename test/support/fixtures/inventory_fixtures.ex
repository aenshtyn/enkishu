defmodule Farm.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Inventory` context.
  """

  @doc """
  Generate a machinery.
  """
  def machinery_fixture(attrs \\ %{}) do
    {:ok, machinery} =
      attrs
      |> Enum.into(%{
        area_of_use: "some area_of_use",
        brand: "some brand",
        hp: 120.5,
        name: "some name",
        price: 120.5
      })
      |> Farm.Inventory.create_machinery()

    machinery
  end

  @doc """
  Generate a medication.
  """
  def medication_fixture(attrs \\ %{}) do
    {:ok, medication} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        patient: "some patient",
        type: "some type"
      })
      |> Farm.Inventory.create_medication()

    medication
  end

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        name: "some name",
        quantity: 120.5,
        unit: "some unit"
      })
      |> Farm.Inventory.create_product()

    product
  end
end
