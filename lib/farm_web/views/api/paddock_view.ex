defmodule FarmWeb.Api.PaddockView do
  use FarmWeb, :view
  alias FarmWeb.Api.PaddockView

  def render("index.json", %{paddocks: paddocks}) do
    %{data: render_many(paddocks, PaddockView, "paddock.json")}
  end

  def render("show.json", %{paddock: paddock}) do
    %{data: render_one(paddock, PaddockView, "paddock.json")}
  end

  def render("paddock.json", %{paddock: paddock}) do
    %{
      id: paddock.id,
      number: paddock.number,
      size: paddock.size,
      description: paddock.description
    }
  end
end
