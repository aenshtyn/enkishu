defmodule FarmWeb.Api.PatronView do
  use FarmWeb, :view
  alias FarmWeb.Api.PatronView

  def render("index.json", %{patrons: patrons}) do
    %{data: render_many(patrons, PatronView, "patron.json")}
  end

  def render("show.json", %{patron: patron}) do
    %{data: render_one(patron, PatronView, "patron.json")}
  end

  def render("patron.json", %{patron: patron}) do
    %{
      id: patron.id,
      name: patron.name,
      phone_number: patron.phone_number,
      address: patron.address,
      role_id: patron.role_id,
      cows: Enum.map(patron.cows, &render_cows(&1))
    }
  end

  def render_cows(cows) do
    %{name: cows.name, age: cows.age, breed: cows.breed}
  end

  def render_milks(milks) do
    %{day: milks.day, schedule: milks.milking_time, volume: milks.volume}
  end

  def render_events(events) do
    %{day: events.day, activity: events.activity, cost: events.cost}
  end
end
