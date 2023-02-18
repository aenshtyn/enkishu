defmodule Farm.EventsTest do
  use Farm.DataCase

  alias Farm.Events

  describe "events" do
    alias Farm.Events.Event

    import Farm.EventsFixtures

    @invalid_attrs %{activity: nil, cost: nil, day: nil, name: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{
        activity: "some activity",
        cost: 42,
        day: ~N[2022-06-16 07:50:00],
        name: "some name"
      }

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.activity == "some activity"
      assert event.cost == 42
      assert event.day == ~N[2022-06-16 07:50:00]
      assert event.name == "some name"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()

      update_attrs = %{
        activity: "some updated activity",
        cost: 43,
        day: ~N[2022-06-17 07:50:00],
        name: "some updated name"
      }

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.activity == "some updated activity"
      assert event.cost == 43
      assert event.day == ~N[2022-06-17 07:50:00]
      assert event.name == "some updated name"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
