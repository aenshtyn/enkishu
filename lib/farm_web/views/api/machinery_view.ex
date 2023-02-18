defmodule FarmWeb.Api.MachineryView do
  use FarmWeb, :view
  alias FarmWeb.Api.MachineryView

  def render("index.json", %{machinerys: machinerys}) do
    %{data: render_many(machinerys, MachineryView, "machinery.json")}
  end

  def render("show.json", %{machinery: machinery}) do
    %{data: render_one(machinery, MachineryView, "machinery.json")}
  end

  def render("machinery.json", %{machinery: machinery}) do
    %{
      id: machinery.id,
      name: machinery.name,
      brand: machinery.brand,
      hp: machinery.hp,
      price: machinery.price,
      area_of_use: machinery.area_of_use
    }
  end
end
