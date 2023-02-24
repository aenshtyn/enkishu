defmodule Farm.FinanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Finance` context.
  """

  @doc """
  Generate a sales.
  """
  def sales_fixture(attrs \\ %{}) do
    {:ok, sales} =
      attrs
      |> Enum.into(%{
        customer_name: "some customer_name",
        day: ~N[2022-06-28 08:06:00],
        price: 120.5,
        quantity: 120.5,
        unit: "some unit"
      })
      |> Farm.Finance.create_sales()

    sales
  end

  @doc """
  Generate a procurements.
  """
  def procurements_fixture(attrs \\ %{}) do
    {:ok, procurements} =
      attrs
      |> Enum.into(%{
        day: ~N[2022-06-28 08:12:00],
        quantity: 120.5,
        unit: "some unit",
        vendor_name: "some vendor_name"
      })
      |> Farm.Finance.create_procurements()

    procurements
  end

  @doc """
  Generate a salary.
  """
  def salary_fixture(attrs \\ %{}) do
    {:ok, salary} =
      attrs
      |> Enum.into(%{
        amount: 120.5,
        grade: 42
      })
      |> Farm.Finance.create_salary()

    salary
  end

  @doc """
  Generate a customer.
  """
  def customer_fixture(attrs \\ %{}) do
    {:ok, customer} =
      attrs
      |> Enum.into(%{
        location: "some location",
        name: "some name",
        phone_number: 42
      })
      |> Farm.Finance.create_customer()

    customer
  end
end
