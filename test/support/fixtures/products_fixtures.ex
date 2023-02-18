defmodule Farm.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Products` context.
  """

  @doc """
  Generate a milk.
  """
  def milk_fixture(attrs \\ %{}) do
    {:ok, milk} =
      attrs
      |> Enum.into(%{
        day: ~D[2022-02-28],
        milking_time: "some milking_time",
        volume: 120.5
      })
      |> Farm.Products.create_milk()

    milk
  end
end
