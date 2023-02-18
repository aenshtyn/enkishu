defmodule Farm.AnimalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Animals` context.
  """

  @doc """
  Generate a cow.
  """
  def cow_fixture(attrs \\ %{}) do
    {:ok, cow} =
      attrs
      |> Enum.into(%{
        breed: "some breed",
        dob: ~D[2022-02-28],
        name: "some name",
        owner: "some owner"
      })
      |> Farm.Animals.create_cow()

    cow
  end

  @doc """
  Generate a sheep.
  """
  def sheep_fixture(attrs \\ %{}) do
    {:ok, sheep} =
      attrs
      |> Enum.into(%{
        age: "some age",
        name: "some name"
      })
      |> Farm.Animals.create_sheep()

    sheep
  end
end
