defmodule FarmWeb.Api.EventView do
  use FarmWeb, :view
  alias FarmWeb.Api.EventView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{
      id: event.id,
      activity: event.activity,
      day: event.day,
      cost: event.cost
    }
  end
end
