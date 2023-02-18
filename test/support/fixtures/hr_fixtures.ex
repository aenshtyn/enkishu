defmodule Farm.HRFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.HR` context.
  """

  @doc """
  Generate a worker.
  """
  def worker_fixture(attrs \\ %{}) do
    {:ok, worker} =
      attrs
      |> Enum.into(%{
        address: "some address",
        dob: ~N[2022-06-27 08:30:00],
        name: "some name",
        phone_number: 42,
        report_date: ~N[2022-06-27 08:30:00]
      })
      |> Farm.HR.create_worker()

    worker
  end

  @doc """
  Generate a patron.
  """
  def patron_fixture(attrs \\ %{}) do
    {:ok, patron} =
      attrs
      |> Enum.into(%{
        address: "some address",
        name: "some name",
        phone_number: 42
      })
      |> Farm.HR.create_patron()

    patron
  end

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Farm.HR.create_role()

    role
  end

  @doc """
  Generate a duty.
  """
  def duty_fixture(attrs \\ %{}) do
    {:ok, duty} =
      attrs
      |> Enum.into(%{
        day: ~N[2022-06-27 08:35:00],
        description: "some description",
        name: "some name"
      })
      |> Farm.HR.create_duty()

    duty
  end

  @doc """
  Generate a worker.
  """
  def worker_fixture(attrs \\ %{}) do
    {:ok, worker} =
      attrs
      |> Enum.into(%{
        adress: "some adress",
        dob: ~N[2022-06-27 08:46:00],
        name: "some name",
        phone_number: 42,
        report_date: ~N[2022-06-27 08:46:00]
      })
      |> Farm.HR.create_worker()

    worker
  end

  @doc """
  Generate a duty.
  """
  def duty_fixture(attrs \\ %{}) do
    {:ok, duty} =
      attrs
      |> Enum.into(%{
        day: ~N[2022-06-27 08:49:00],
        description: "some description",
        name: "some name"
      })
      |> Farm.HR.create_duty()

    duty
  end
end
