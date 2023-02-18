defmodule FarmWeb.Api.MilkView do
  use FarmWeb, :view
  alias FarmWeb.Api.MilkView

  def render("index.json", %{milks: milks}) do
    %{data: render_many(milks, MilkView, "milk.json")}
  end

  def render("show.json", %{milk: milk}) do
    %{data: render_one(milk, MilkView, "milk.json")}
  end

  def render("milk.json", %{milk: milk}) do
    %{
      id: milk.id,
      day: milk.day,
      volume: milk.volume,
      milking_time: milk.milking_time,
      cow_id: milk.cow_id
    }
  end
end
