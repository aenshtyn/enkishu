defmodule FarmWeb.Api.DutyView do
  use FarmWeb, :view
  alias FarmWeb.Api.DutyView

  def render("index.json", %{duties: duties}) do
    %{data: render_many(duties, DutyView, "duty.json")}
  end

  def render("show.json", %{duty: duty}) do
    %{data: render_one(duty, DutyView, "duty.json")}
  end

  def render("duty.json", %{duty: duty}) do
    %{
      id: duty.id,
      day: duty.day,
      name: duty.name,
      description: duty.description
    }
  end
end
