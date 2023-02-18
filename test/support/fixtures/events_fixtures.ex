defmodule Farm.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Farm.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        activity: "some activity",
        cost: 42,
        day: ~N[2022-06-16 07:50:00],
        name: "some name"
      })
      |> Farm.Events.create_event()

    event
  end
end
