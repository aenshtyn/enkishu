defmodule FarmWeb.Api.CowView do
  use FarmWeb, :view
  alias FarmWeb.Api.CowView

  def render("index.json", %{cows: cows}) do
    %{data: render_many(cows, CowView, "cow.json")}
  end

  def render("show.json", %{cow: cow}) do
    %{data: render_one(cow, CowView, "cow.json")}
  end

  def render("cow.json", %{cow: cow}) do
    %{
      id: cow.id,
      name: cow.name,
      age: cow.age,
      breed: cow.breed,
      owner: cow.patron_id,
      milks: Enum.map(cow.milks, &render_milks(&1)),
      # events: Enum.map(cow.events, &render_events(&1))
    }
  end

  def render_milks(milks) do
    %{day: milks.day, schedule: milks.milking_time, volume: milks.volume}
  end

  def render_events(events) do
    %{day: events.day, activity: events.activity, cost: events.cost}
  end
end
